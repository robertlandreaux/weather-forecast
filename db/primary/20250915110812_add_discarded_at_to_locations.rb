class AddDiscardedAtToLocations < ActiveRecord::Migration[8.0]
  def change
    change_table :locations, bulk: true do |t|
      t.timestamp :discarded_at, :datetime
      t.index :discarded_at
    end
  end
end
