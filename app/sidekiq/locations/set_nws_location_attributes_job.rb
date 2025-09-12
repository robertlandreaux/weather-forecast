module Locations
  class SetNwsLocationAttributesJob
    include Sidekiq::Job

    def perform(location_id)
      Locations::SetNwsLocationAttributes.new(location_id:).run
    end
  end
end
