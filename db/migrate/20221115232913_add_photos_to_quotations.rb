class AddPhotosToQuotations < ActiveRecord::Migration[7.0]
  def change
    add_column :quotations, :photos, :string
  end
end
