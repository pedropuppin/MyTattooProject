class CreateQuotations < ActiveRecord::Migration[7.0]
  def change
    create_table :quotations do |t|
      t.string :size
      t.string :placement
      t.date :date
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.integer :artist_id

      t.timestamps
    end
  end
end
