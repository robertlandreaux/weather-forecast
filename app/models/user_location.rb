class UserLocation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :location, optional: true

  validates :user_id, presence: true
  validates :location_id, presence: true
end
