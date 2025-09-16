class AddForecastsDataNullConstraint < ActiveRecord::Migration[8.0]
  def change
    change_column_null :forecasts, :data, false
  end
end
