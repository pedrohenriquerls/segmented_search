class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |c|
      c.string :name
      c.string :email
      c.string :state
      c.string :role
      c.integer :age
      c.timestamps null: false
    end
  end
end