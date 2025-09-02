module Integrations
  module Nws
    class Points
      def initialize(latitude:, longitude:)
        @latitude = latitude
        @longitude = longitude
      end

      def run
        get_points
      end

      private

      attr_reader :latitude
      attr_reader :longitude

      def get_points
        url = "/points/#{latitude},#{longitude}"
        response = Integration::Nws::Api.new(method: "get", url:).run

        response.slice(
          "gridId",
          "gridX",
          "gridY"
        )
      end
    end
  end
end
