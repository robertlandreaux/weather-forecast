class CreateUserLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :user_locations do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :location, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
