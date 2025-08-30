# frozen_string_literal: true

module Integration
  module Geocoder
    class GeocodeLocation
      # @param location [Location]
      def initialize(location_id:)
        @location = Location.find(location_id)
      end

      def run
        results = ::Geocoder.search(address)

        if results&.first&.coordinates
          latitude, longitude = results.first.coordinates
          location.update!(latitude:, longitude:)
        else
          Rails.logger.info("No coordinates found for #{location.address}")
        end
      end

      private

      attr_reader :location
    end
  end
end
