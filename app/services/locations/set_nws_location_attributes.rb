module Locations
  class SetNwsLocationAttributes
    def initialize(location_id:)
      @location = Location.find(location_id)
    end

    def run
      location_attributes = Integration::Nws::Points.new(latitude: location.latitude, longitude: location.longitude).run

      if location_attributes
        location.update!(
          nws_grid_id: location_attributes["gridId"],
          nws_grid_x: location_attributes["gridX"],
          nws_grid_y: location_attributes["gridY"]
        )
      end
    end

    private

    attr_reader :location
  end
end
