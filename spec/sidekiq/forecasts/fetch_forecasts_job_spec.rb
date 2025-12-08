require "rails_helper"

RSpec.describe Forecasts::FetchForecastsJob, type: :job do
  let!(:location_1) {
    FactoryBot.create(
      :us_location,
      time_zone: "America/New_York",
      nws_grid_id: "NY123"
    )
  }

  let!(:location_2) {
    FactoryBot.create(
      :us_location,
      time_zone: "America/Los_Angeles",
      nws_grid_id: "CA456"
    )
  }

  let!(:location_3) {
    FactoryBot.create(
      :us_location,
      time_zone: "America/New_York",
      nws_grid_id: nil
    )
  }

  describe "#perform" do
    before do
      allow(Forecasts::FetchForecastJob).to receive(:perform_bulk)
      travel_to(Time.utc(2024, 1, 1, 11, 0, 0)) # 6 AM in New York
    end
    it "enqueues Forecasts::FetchForecastJob for locations in target time zones" do
      described_class.new.perform
      expect(Forecasts::FetchForecastJob).to have_received(:perform_bulk).with([[location_1.id]])
    end
  end
end
