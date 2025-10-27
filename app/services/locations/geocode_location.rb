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
        publish_event
      else
        Rails.logger.info("No coordinates found for #{location.address_for_geocoding}")
      end
    end

    private

    def publish_event
      Rails.configuration.event_store.publish(
        Locations::LocationGeocoded.new(data: {location_id: location.id}),
        stream_name: "Location_#{location.id}",
        expected_version: :any
      )
    end
  end
end
