module Locations
  class SetNwsLocationAttributes
    def initialize(location_id:)
      @location = Location.find(location_id)
    end

    def run
      location_attributes = Integration::Nws::Points.new(
        # Truncate the latitude and longitude because sometimes the NWS API returns
        # 404 for very precise coordinates.
        latitude: location.latitude.truncate(2),
        longitude: location.longitude.truncate(2)
      ).run

      if location_attributes
        location.update!(
          nws_grid_id: location_attributes["gridId"],
          nws_grid_x: location_attributes["gridX"],
          nws_grid_y: location_attributes["gridY"]
        )
        Forecasts::FetchForecastJob.perform_async(location.id)
      end
    end

    private

    attr_reader :location
  end
end
