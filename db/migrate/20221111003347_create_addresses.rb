class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :zipcode
      t.string :country
      t.string :city
      t.string :street
      t.string :number

      t.timestamps
    end
  end
end
