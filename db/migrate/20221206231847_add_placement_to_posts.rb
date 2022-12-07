class AddPlacementToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :placement, :string
  end
end
