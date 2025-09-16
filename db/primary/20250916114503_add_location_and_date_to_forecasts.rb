class AddLocationAndDateToForecasts < ActiveRecord::Migration[8.0]
  def change
    change_table :forecasts, bulk: true do |t|
      t.references :location, foreign_key: true, null: false
      t.date :date, null: false
    end
  end
end
