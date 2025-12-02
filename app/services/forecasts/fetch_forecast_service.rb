module Forecasts
  class FetchForecastService
    class MissingNwsGridId < StandardError; end

    def initialize(location_id:)
      @location = Location.find(location_id)
    end

    def run
      return if forecast_exists?

      validate_location!

      forecast = Forecast.create!(location:, data: fetched_forecast, date: Date.current)
      event = Forecasts::ForecastCreated.new(data: {forecast_id: forecast.id})
      Rails.configuration.event_store.publish(
        event,
        stream_name: "Forecast_#{forecast.id}",
        expected_version: :any
      )
    end

    private

    attr_reader :location

    def fetched_forecast
      forecast = Integration::Nws::Forecast.new(
        grid_id: location.nws_grid_id,
        grid_x: location.nws_grid_x,
        grid_y: location.nws_grid_y
      ).run

      {
        "today" => forecast["properties"]["periods"][0],
        "tonight" => forecast["properties"]["periods"][1]
      }
    end

    def validate_location!
      raise MissingNwsGridId if location.nws_grid_id.blank?
    end

    def forecast_exists?
      Forecast.exists?(location: location, date: Date.current)
    end
  end
end
