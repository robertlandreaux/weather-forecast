require "rails_helper"

RSpec.describe UserLocation, type: :model do
  it { is_expected.to belong_to(:user).optional }
  it { is_expected.to belong_to(:location).optional }

  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:location_id) }
end
