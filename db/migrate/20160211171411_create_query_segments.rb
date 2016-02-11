class CreateQuerySegments < ActiveRecord::Migration
  def change
    create_table :query_segments do |q|
      q.string :name
      q.string :params
      q.timestamps null: false
    end
  end
end
