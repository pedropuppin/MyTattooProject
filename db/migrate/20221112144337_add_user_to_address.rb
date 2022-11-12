class AddUserToAddress < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :user, null: false, foreign_key: true
    remove_reference :users, :addresses
  end
end
