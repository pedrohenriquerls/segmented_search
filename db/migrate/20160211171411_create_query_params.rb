class CreateQueryParams < ActiveRecord::Migration
  def change
    create_table :query_params do |q|
      q.string :name
      q.string :query
      q.timestamps null: false
    end
  end
end
