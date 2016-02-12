function QuerySegmentForm(OPERATOR_STRING, OPERATOR_INTEGER, MODEL_ATTRIBUTES_STRING, MODEL_ATTRIBUTES_INTEGER){
  this.OPERATOR_STRING = OPERATOR_STRING
  this.OPERATOR_INTEGER = OPERATOR_INTEGER
  this.MODEL_ATTRIBUTES_STRING = MODEL_ATTRIBUTES_STRING
  this.MODEL_ATTRIBUTES_INTEGER = MODEL_ATTRIBUTES_INTEGER

  var html = $("#segment_template_form").html()
  this.form_template = Handlebars.compile(html)

  html = $("#segment_operators_template").html()
  this.operator_template = Handlebars.compile(html)
  this.$container = $('#form_container')

  this.new_group();
}

QuerySegmentForm.prototype = {
  new_group: function(){
    var group_name = this.group_name();
    var form_params = {
      group_name: group_name,
      attributes: this.get_all_attributes(),
      operators: this.OPERATOR_STRING
    }

    var form_html = this.form_template(form_params)
    this.$container.append(form_html)
    this.assign_group_events(group_name)
    this.assign_form()
  },
  group_name: function(number){
    if(!number)
      number = this.$container.children().length
    return 'group-'+number
  },
  assign_group_events: function(group_name){
    var $group = $('.'+group_name),
      integer_operators = {operators: this.OPERATOR_INTEGER},
      string_operators  = {operators: this.OPERATOR_STRING},
      me = this;


    $group.find('.attribute_name').on('change', function(){
      var name = $(this).val(),
        $value = $group.find('.value'),
        $parent = $group.find('.operator_container')

      if(_.indexOf(me.MODEL_ATTRIBUTES_STRING, name) != -1){
        $parent.html(me.operator_template(string_operators))
        $value.attr('type', 'text')
      } else{
        $parent.html(me.operator_template(integer_operators))
        $value.attr('type', 'number')
      }
    })
  },
  get_all_attributes: function(){
    return this.MODEL_ATTRIBUTES_STRING.concat(this.MODEL_ATTRIBUTES_INTEGER)
  },
  assign_form: function(){
    var me = this;
    $('#submit').on('click', function(e{
      e.preventDefault();
      console.log(me.groups_to_json())
    })
  },
  groups_to_json: function(){
    var json = {}
    _.forEach(this.$container.children(), function(group){
      var $group = $(group)
      var name = $group.find('.attribute_name').val()
      json[name] = {
        operator: $group.find('.operator').val(),
        value: $group.find('.value').val()
      }
    })
    return json
  }
}