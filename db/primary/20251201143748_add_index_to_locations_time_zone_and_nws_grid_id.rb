class AddIndexToLocationsTimeZoneAndNwsGridId < ActiveRecord::Migration[8.1]
  def change
    add_index :locations, [:time_zone, :nws_grid_id]
  end
end
