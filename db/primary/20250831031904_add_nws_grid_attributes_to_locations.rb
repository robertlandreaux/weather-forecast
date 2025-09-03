class AddNwsGridAttributesToLocations < ActiveRecord::Migration[8.0]
  def change
    add_column :locations, :nws_grid_id, :string
    add_column :locations, :nws_grid_x, :integer
    add_column :locations, :nws_grid_y, :integer
  end
end
