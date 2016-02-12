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
    JSON.parse(@params)
  end

  def params_to_query
    query  = ''
    params.each do |key, value|
      if key.to_s == GROUP
        query += " #{value} "
      elsif
        query += "#{key} #{value}"
      end
    end
    query
  end
end
