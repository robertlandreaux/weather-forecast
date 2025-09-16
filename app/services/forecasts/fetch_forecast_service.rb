module Forecasts
  class FetchForecastService
    def initialize(location_id:)
      @location = Location.find(location_id)
    end

    def run
      Forecast.create!(location:, data: forecast, date: Date.current)
    end

    private

    attr_reader :location

    def forecast
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
