module Locations
  class SetNwsLocationAttributesJob
    include Sidekiq::Job

    sidekiq_options queue: :nws, retry: false

    def perform(location_id)
      Locations::SetNwsLocationAttributes.new(location_id:).run
    end
  end
end
