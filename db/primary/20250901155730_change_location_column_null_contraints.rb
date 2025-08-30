class ChangeLocationColumnNullContraints < ActiveRecord::Migration[8.0]
  def change
    change_column_null :locations, :address_line_1, true
    change_column_null :locations, :address_line_2, true
    change_column_null :locations, :address_line_3, true
    change_column_null :locations, :address_line_4, true
    change_column_null :locations, :address_line_5, true
    change_column_null :locations, :address_line_6, true
    change_column_null :locations, :latitude, true
    change_column_null :locations, :longitude, true
    change_column_null :locations, :name, true
  end
end
