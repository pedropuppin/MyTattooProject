class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :string
    add_column :users, :role, :string
    add_reference :users, :addresses, null: false, foreign_key: true
  end
end
