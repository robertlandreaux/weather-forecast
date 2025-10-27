module Locations
  class GeocodeLocationJob
    include Sidekiq::Job
    sidekiq_options queue: :geocoding, retry: false

    def perform(event)
      location_id = event.data["location_id"]
      Locations::GeocodeLocation.new(location_id: event.data[:location_id]).run
    end
  end
end

Rails.configuration.event_store.subscribe(Locations::GeocodeLocationJob, to: [Locations::LocationCreated])
