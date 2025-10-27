module Locations
  class GeocodeLocation
    # @param location_id [Integer]
    def initialize(location_id:)
      @location = Location.find(location_id)
    end

    def run
      results = ::Geocoder.search(location.address_for_geocoding)

      if results&.first&.coordinates
        latitude, longitude = results.first.coordinates
        time_zone = Timezone.lookup(latitude, longitude).name
        location.update!(latitude:, longitude:, time_zone: time_zone)
        set_nws_location_attributes
      else
        Rails.logger.info("No coordinates found for #{location.address_for_geocoding}")
      end
    end

    private

    attr_reader :location

    def set_nws_location_attributes
      Locations::SetNwsLocationAttributesJob.perform_async(location.id)
    end
  end
end
