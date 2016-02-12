require 'json'

class QuerySegment < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with QueryBlacklistValidator

  GROUP='group'

  validates_presence_of :name, :params
  attr_accessor :params

  def contacts
    Contact.where(params_to_query)
  end

  def params=(params)

    @params = params.to_json
    super
  end

  def params
    JSON.parse(@params) rescue ''
  end

  def params_to_query
    query  = ''
    params.each do |key, object|
      if key.to_s == GROUP
        query += " #{object} "
      elsif
        query += "#{key} #{object['operator']} #{object['value']}"
      end
    end
    query
  end
end
