module Locations
  class GeocodeLocation
    # @param location [Location]
    def initialize(location_id:)
      @location = Location.find(location_id)
    end

    def run
      results = ::Geocoder.search(location.address_for_geocoding)

      if results&.first&.coordinates
        latitude, longitude = results.first.coordinates
        time_zone = Timezone.lookup(latitude, longitude).name
        location.update!(latitude:, longitude:, time_zone: time_zone)
      else
        Rails.logger.info("No coordinates found for #{location.address_for_geocoding}")
      end
    end

    private

    attr_reader :location
  end
end
