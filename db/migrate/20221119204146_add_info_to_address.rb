class AddInfoToAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :neighborhood, :string
    add_column :addresses, :state, :string
  end
end
