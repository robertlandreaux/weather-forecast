module Integration
  module Nws
    class Points
      def initialize(latitude:, longitude:)
        @latitude = latitude
        @longitude = longitude
      end

      def run
        get_points_response.slice(
          "gridId",
          "gridX",
          "gridY"
        )
      end

      private

      attr_reader :latitude
      attr_reader :longitude

      def get_points_response
        path = "/points/#{latitude},#{longitude}"
        response = Integration::Nws::Api.new(method: "get", path:).run

        JSON.parse(response.body)
      end
    end
  end
end
