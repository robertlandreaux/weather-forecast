module Locations
  class GeocodeLocationJob
    include Sidekiq::Job
    sidekiq_options queue: :geocoding, retry: false

    def perform(location_id)
      Locations::GeocodeLocation.new(location_id:).run
    end
  end
end
