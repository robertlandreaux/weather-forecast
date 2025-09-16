class AddTimeZoneToLocations < ActiveRecord::Migration[8.0]
  def change
    add_column :locations, :time_zone, :string
  end
end
