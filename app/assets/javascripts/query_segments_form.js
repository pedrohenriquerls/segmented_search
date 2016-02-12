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

  this.assign_form()
}

QuerySegmentForm.prototype = {
  new_group: function(){
    var group_name = this.group_name();
    var form_params = {
      group_name: group_name,
      attributes: this.get_all_attributes(),
      operators: this.OPERATOR_STRING,
    }

    var form_html = this.form_template(form_params)
    this.$container.append(form_html)
    this.assign_group_events(group_name)
    return group_name
  },
  group_name: function(number){
    if(!number)
      number = this.$container.children('.bs-group').length
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

      if(me.is_string_attr(name)){
        $parent.html(me.operator_template(string_operators))
        $value.attr('type', 'text')
      } else{
        $parent.html(me.operator_template(integer_operators))
        $value.attr('type', 'number')
      }
    })

    $group.next('.operator_logical').on('change', function(){
      var logical_operator = $(this).val()
      if(_.isEmpty(logical_operator)){
        $(this).next().remove()
        $(this).remove()
      } else
        me.new_group()
    })
  },
  is_string_attr: function(name){
    return -1 < _.indexOf(this.MODEL_ATTRIBUTES_STRING, name)
  },
  get_all_attributes: function(){
    return this.MODEL_ATTRIBUTES_STRING.concat(this.MODEL_ATTRIBUTES_INTEGER)
  },
  assign_form: function(){
    var me = this;
    $('#submit').on('click', function(e){
      e.preventDefault();

      var $form = $(this).parent(),
        _method = $('[name=_method]').val(),
        data = {
          query_segment:{
            name: $('#query_segment_name').val(),
            criteria: JSON.stringify(me.groups_to_json())
          }
        }

      $.ajax({
        url: $form.attr('action'),
        method: _method ? 'PUT':$form.attr('method'),
        data: data,
        success: function(response){
          $('body').html(response);
        }
      })
    })
  },
  groups_to_json: function(){
    var json = {}

    _.forEach(this.$container.children('.bs-group'), function(group){
      var $group = $(group)
      var name = $group.find('.attribute_name').val(),
        logical_operator = $group.next('.operator_logical').val(),
        value = $group.find('.value').val()

      json[name] = {
        operator: $group.find('.operator').val(),
        value: value
      }

      if(!_.isEmpty(logical_operator))
        json[name]['group'] = logical_operator
    })

    return json
  },
  edit_form: function(json){
    var me = this
    _.forEach(json, function(object, name){
      var $new_group = $('.'+me.new_group())

      $new_group.find('.attribute_name').val(name)
      $new_group.find('.operator').val(object.operator)
      $new_group.find('.value').val(object.value)
      $new_group.next().val(object.group)
    })
  }
}