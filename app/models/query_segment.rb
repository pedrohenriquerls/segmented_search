class QuerySegment < ActiveRecord::Base
  GROUP='group'

  validates_presence_of :name, :query

  attr_accessible :query

  def query=(query_params)
    q = ''
    query_params.each do |key, value|
      if key == GROUP
        q += " #{value} "
      elsif
        q += "#{key} #{value}"
      end
    end

    write_attribute(:query, q)
  end
end
