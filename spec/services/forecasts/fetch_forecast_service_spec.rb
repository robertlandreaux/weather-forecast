require "rails_helper"

RSpec.describe Forecasts::FetchForecastService, type: :service do
  include_context "with application data"

  let(:service) { described_class.new(location_id: location.id) }

  let(:location) { TestProf::AnyFixture.cached(:us_location_1) }

  describe "#run" do
    subject(:run) { service.run }

    before do
      allow(Integration::Nws::Forecast).to receive(:new).and_return(forecast)
      allow(Rails.configuration.event_store).to receive(:publish).and_return(true)
    end

    let(:forecast) { instance_double(Integration::Nws::Forecast, run: JSON.parse(forecast_response)) }

    let(:forecast_response) {
      file_fixture("services/integration/nws/forecast_response.json").read
    }

    it "uses Integration::Nws::Forecast#run" do
      run
      expect(Integration::Nws::Forecast).to have_received(:new)
        .with(grid_id: location.nws_grid_id, grid_x: location.nws_grid_x, grid_y: location.nws_grid_y)
      expect(forecast).to have_received(:run)
    end

    it "creates a Forecast record with the forecast data" do
      expect { run }.to change(Forecast, :count).by(1)
      forecast_record = Forecast.last
      expect(forecast_record.location_id).to eq(location.id)
      expect(forecast_record.date).to eq(Date.current)
      expect(forecast_record.data).to include(
        "today" => a_hash_including(
          "name" => "Today",
          "temperature" => 88,
          "temperatureUnit" => "F",
          "windSpeed" => "2 to 6 mph",
          "windDirection" => "E",
          "shortForecast" => "Mostly Sunny",
          "detailedForecast" => "Mostly sunny, with a high near 88. East wind 2 to 6 mph."
        ),
        "tonight" => a_hash_including(
          "name" => "Tonight",
          "temperature" => 59,
          "temperatureUnit" => "F",
          "windSpeed" => "2 to 6 mph",
          "windDirection" => "E",
          "shortForecast" => "Partly Cloudy",
          "detailedForecast" => "Partly cloudy, with a low around 59. East wind 2 to 6 mph."
        )
      )
    end

    it "publishes a ForecastCreated event" do
      run
      forecast_record = Forecast.last
      expect(Rails.configuration.event_store).to have_received(:publish).with(
        an_instance_of(Forecasts::ForecastCreated),
        stream_name: "Forecast_#{forecast_record.id}",
        expected_version: :any
      )
    end

    context "when the location is missing nws_grid_id" do
      let(:location) {
        FactoryBot.create(
          :us_location,
          nws_grid_id: nil
        )
      }

      it "raises a MissingNwsGridId error" do
        expect { run }.to raise_error(Forecasts::FetchForecastService::MissingNwsGridId)
      end
    end

    context "when a forecast already exists for the location and date" do
      let!(:forecast) {
        FactoryBot.create(
          :forecast,
          location: location,
          date: Date.current
        )
      }

      it "does not create a new forecast" do
        expect { run }.not_to change(Forecast, :count)
      end

      it "does not use Integration::Nws::Forecast" do
        run
        expect(Integration::Nws::Forecast).not_to have_received(:new)
      end
    end
  end
end
