module Locations
  class CreateLocationService
    def initialize(location_attributes:)
      @location_attributes = location_attributes
    end

    def run
      find_or_create_location
    end

    private

    attr_reader :location_attributes

    def find_or_create_location
      location = Location.find_or_initialize_by(
        address_line_3: location_attributes[:city],
        address_line_4: location_attributes[:state],
        address_line_5: location_attributes[:zip_code],
        country_code: location_attributes[:country_code]
      )

      if location.new_record?
        location.save!
        publish_event(location.id)
      end

      location
    end

    def publish_event(location_id)
      event = Locations::LocationCreated.new(data: {location_id: location_id})
      Rails.configuration.event_store.publish(
        event,
        stream_name: "Location_#{location_id}",
        expected_version: :any
      )
    end
  end
end
