module Integration
  module Nws
    class Points
      def initialize(latitude:, longitude:)
        @latitude = latitude
        @longitude = longitude
      end

      def run
        path = "/points/#{latitude},#{longitude}"
        Integration::Nws::Api.new(method: "get", path:).run
      end

      private

      attr_reader :latitude
      attr_reader :longitude
    end
  end
end
