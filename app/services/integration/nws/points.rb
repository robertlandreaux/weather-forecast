module Integration
  module Nws
    class Points
      def initialize(latitude:, longitude:)
        @latitude = latitude
        @longitude = longitude
      end

      def run
        path = "/points/#{latitude},#{longitude}"
        Integration::Nws::Api.new(request_method: "get", path:).parsed_response
      end

      private

      attr_reader :latitude
      attr_reader :longitude
    end
  end
end
