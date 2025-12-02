module Locations
  class SetNwsLocationAttributes
    class LocationMissingCoordinates < StandardError; end

    def initialize(location_id:)
      @location = Location.find(location_id)
    end

    def run
      validate_location!

      if location_attributes
        properties = location_attributes["properties"]
        location.update!(
          nws_grid_id: properties["gridId"],
          nws_grid_x: properties["gridX"],
          nws_grid_y: properties["gridY"]
        )

        Forecasts::FetchForecastJob.perform_async(location.id) if location.nws_grid_id.present?
      end
    end

    private

    attr_reader :location

    def validate_location!
      if location.latitude.blank? || location.longitude.blank?
        raise LocationMissingCoordinates, "Location must have latitude and longitude set"
      end
    end

    def location_attributes
      @location_attributes ||= Integration::Nws::Points.new(
        # Truncate the latitude and longitude because sometimes the NWS API returns
        # 404 for very precise coordinates.
        latitude: location.latitude.truncate(2),
        longitude: location.longitude.truncate(2)
      ).run
    rescue => e
      Rails.logger.error("Failed to fetch NWS location attributes: #{e.message}")
    end
  end
end
