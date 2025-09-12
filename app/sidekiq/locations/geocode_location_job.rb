module Locations
  class GeocodeLocationJob
    include Sidekiq::Job

    # @param location_id [String]
    def perform(location_id)
      Locations::GeocodeLocation.new(location_id:).run
    end
  end
end
