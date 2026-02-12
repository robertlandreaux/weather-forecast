require "rails_helper"

RSpec.describe Forecasts::Notifiers::NewForecast, type: :service do
  include_context "with application data"

  let(:service) { described_class.new(forecast_id: forecast.id) }

  let(:forecast) { TestProf::AnyFixture.cached(:forecast_1_us_location) }
  let(:location) { forecast.location }
  let(:user1) { TestProf::AnyFixture.cached(:user_1) }
  let(:user2) { TestProf::AnyFixture.cached(:user_2) }

  let(:bulk_enqueue_mailers) { instance_double(BulkEnqueueMailers, run: nil) }

  before do
    location.users << user1
    location.users << user2
    allow(BulkEnqueueMailers).to receive(:new).and_return(bulk_enqueue_mailers)
  end

  describe "#run" do
    subject(:run) { service.run }

    it "sends new forecast emails to all users associated with the forecast's location" do
      run
      expect(BulkEnqueueMailers).to have_received(:new).with(
        mail_class: ForecastMailer,
        template: :new_forecast,
        mailer_args: [[forecast.id, user1], [forecast.id, user2]]
      )
      expect(bulk_enqueue_mailers).to have_received(:run)
    end
  end
end
