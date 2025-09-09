module Integration
  module Nws
    class Api
      NWS_HOSTNAME = "api.weather.gov"
      USER_AGENT = ENV.fetch("NWS_USER_AGENT", "testing")

      def initialize(method:, path:, log_true: true)
        @method = method
        @path = path
        @log_request = log_request
      end

      def run
        connection = Faraday.new(url:, headers: headers) do
          faraday.response :raise_error
        end
        @response = connection.send(method)
        connection.close
        log_nws_request
        JSON.parse(response.body)
      end

      private

      attr_reader :method
      attr_reader :path
      attr_reader :log_request

      def headers
        {
          "User-Agent" => USER_AGENT,
          "Content-Type" => "application/ld+json"
        }
      end

      def url
        "https://#{NWS_HOSTNAME}#{path}"
      end

      def log_nws_request
        if log_request && ENV["LOG_NWS_REQUESTS"] == 1
          ::LogExternalRequestJob.perform_async(
            request_method: method,
            request_headers: headers,
            request_url: url,
            request_body: nil,
            response_headers: @response.headers,
            response_status: @response.status,
            response_body: @response.body,
            metadata: nil
          )
        end
      end
    end
  end
end
