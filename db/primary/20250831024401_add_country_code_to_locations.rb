class AddCountryCodeToLocations < ActiveRecord::Migration[8.0]
  def change
    add_column :locations, :country_code, :string, null: false
  end
end
