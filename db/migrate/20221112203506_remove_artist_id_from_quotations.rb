class RemoveArtistIdFromQuotations < ActiveRecord::Migration[7.0]
  def change
    remove_column :quotations, :artist_id, :string
  end
end
