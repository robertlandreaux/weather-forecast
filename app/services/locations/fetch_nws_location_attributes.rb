module Integration
  module Nws
    class SetLocationAttributes
      def initialize(latitude:, longitude:)
        @latitude = latitude
        @longitude = longitude
      end

      def run
        location_attributes = GetPoints.new(latitude:, longitude:).run

        if location_attributes
          location.update!(
            nws_grid_id: location_attributes["gridId"],
            nws_grid_x: location_attributes["gridX"],
            nws_grid_y: location_attributes["gridY"]
          )
        end
      end
    end
  end
end
