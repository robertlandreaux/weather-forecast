require "rails_helper"

RSpec.describe Forecasts::Notifiers::NewForecast, type: :service do
  include_context "with application data"

  let(:service) { described_class.new(forecast_id: forecast.id) }

  let(:forecast) { TestProf::AnyFixture.cached(:forecast_1_us_location) }
  let(:location) { forecast.location }
  let(:user1) { TestProf::AnyFixture.cached(:user_1) }
  let(:user2) { TestProf::AnyFixture.cached(:user_2) }

  before do
    location.users << user1
    location.users << user2
    allow(ForecastMailer).to receive_message_chain(:new_forecast, :deliver_later)
  end

  describe "#run" do
    subject(:run) { service.run }

    it "sends new forecast emails to all users associated with the forecast's location" do
      run
      expect(ForecastMailer).to have_received(:new_forecast).with(forecast, user1)
      expect(ForecastMailer).to have_received(:new_forecast).with(forecast, user2)
      expect(ForecastMailer).to have_received(:new_forecast).exactly(2).times
    end
  end
end
