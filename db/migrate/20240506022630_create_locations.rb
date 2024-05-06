class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :address_line_1, null: false
      t.string :address_line_2, null: false
      t.string :address_line_3, null: false
      t.string :address_line_4, null: false
      t.string :address_line_5, null: false
      t.string :address_line_6, null: false
      t.timestamps
    end
  end
end
