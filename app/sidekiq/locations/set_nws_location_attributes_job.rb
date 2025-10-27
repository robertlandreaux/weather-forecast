module Locations
  class SetNwsLocationAttributesJob
    include Sidekiq::Job
    sidekiq_options queue: :nws, retry: false

    def perform(event)
      location_id = event.data["location_id"]
      Locations::SetNwsLocationAttributes.new(location_id: event.data["location_id"]).run
    end
  end
end

Rails.configuration.event_store.subscribe(Locations::SetNwsLocationAttributesJob, to: [Locations::LocationGeocoded])
