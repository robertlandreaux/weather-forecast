module Integration
  module Nws
    class Api
      NWS_HOSTNAME = "api.weather.gov"
      USER_AGENT = ENV.fetch("NWS_USER_AGENT", "testing")

      def initialize(method:, path:)
        @method = method
        @path = path
      end

      def run
        response = connection.send(method)
        connection.close
        response
      end

      private

      attr_reader :method
      attr_reader :path

      def headers
        {
          "User-Agent" => USER_AGENT,
          "Content-Type" => "application/ld+json"
        }
      end

      def connection
        @connection ||= Faraday.new(url: "https://#{NWS_HOSTNAME}#{path}", headers: headers) do |faraday|
          faraday.response :raise_error
        end
      end
    end
  end
end
