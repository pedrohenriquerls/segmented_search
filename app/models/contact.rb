class Contact < ActiveRecord::Base
  validates_presence_of :name, :email, :state, :role, :age
end
