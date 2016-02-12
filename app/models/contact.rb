class Contact < ActiveRecord::Base
  include States

  validates_presence_of :name, :email, :state, :role, :age
end
