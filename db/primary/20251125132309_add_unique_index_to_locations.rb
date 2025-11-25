class AddUniqueIndexToLocations < ActiveRecord::Migration[8.1]
  def change
    add_index :locations, [:address_line_3, :address_line_4, :address_line_5, :country_code], unique: true
  end
end
