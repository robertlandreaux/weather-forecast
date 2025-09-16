class Forecast < PrimaryApplicationRecord
  belongs_to :location, optional: true

  validates :data, presence: true
  validates :date, presence: true
  validates :location_id, presence: true
end
