class AddArtistToQuotation < ActiveRecord::Migration[7.0]
  def change
    add_reference :quotations, :artist, null: false, foreign_key: { to_table: :users }
  end
end
