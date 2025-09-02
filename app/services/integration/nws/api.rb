module Integration
  NWS_HOSTNAME = "api.weather.gov"
  USER_AGENT = ENV.fetch("NWS_USER_AGENT", "testing")

  module Nws
    class Api
      def initialize(method:, url:)
        @method = method
        @url = url
        @connection = Faraday.new(url: NWS_HOSTNAME, headers: headers)
      end

      def run
        response = connection.send(method, url) do |faraday|
          faraday.response :json
          faraday.response :raise_error
        end
        connection.close
        response
      end

      private

      attr_reader :method
      attr_reader :url
      attr_reader :connection

      def headers
        {
          "User-Agent" => USER_AGENT,
          "Content-Type" => "application/ld+json"
        }
      end
    end
  end
end
