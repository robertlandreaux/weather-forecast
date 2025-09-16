require "rails_helper"

RSpec.describe Forecast, type: :model do
  it { is_expected.to belong_to(:location).optional }

  it { is_expected.to validate_presence_of(:data) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:location_id) }
end
