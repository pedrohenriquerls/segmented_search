class QueryParam < ActiveRecord::Base
  validates_presence_of :name, :query
end
