module Forecasts
  class FetchForecastService
    def initialize(location_id:)
      @location = Location.find(location_id)
    end

    def run
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
  end
end
