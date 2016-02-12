require 'json'

class QuerySegment < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with QueryBlacklistValidator

  validates_presence_of :name, :criteria

  def contacts
    Contact.where(criteria_to_query)
  end

  def criteria=(p)
    super
    @criteria = JSON.generate(p) rescue p
  end

  def criteria_to_json
    JSON.parse(criteria)
  end

  def criteria_to_query
    q  = ''
    criteria_to_json.each do |key, object|
      value = if Operators::MODEL_ATTRIBUTES_STRING.include? key
        "'#{object['value']}'"
      else
        object['value']
      end

      q += "#{key} #{object['operator']} #{value}"

      group = object['group']
      q += " #{group} " unless group.nil?
    end
    q
  end
end
