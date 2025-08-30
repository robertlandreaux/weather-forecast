module Integration
  module Geocoder
    class GeocodeLocationJob
      include Sidekiq::Job

      # @param location_id [String]
      def perform(location_id)
        Integration::Geocoder::GeocodeLocation.new(location_id:).run
      end
    end
  end
end
