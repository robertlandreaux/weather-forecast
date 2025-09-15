module Integration
  module Nws
    class Api
      NWS_HOSTNAME = "api.weather.gov"

      def initialize(request_method:, path:, log_request: true)
        @request_method = request_method
        @path = path
        @log_request = log_request
      end

      def parsed_response
        @parsed_response ||= begin
          run_request
          JSON.parse(response.body)
        end
      end

      attr_reader :response

      private

      attr_reader :request_method
      attr_reader :path
      attr_reader :log_request

      def run_request
        connection = Faraday.new(url:, headers: request_headers) do |faraday|
          faraday.response :raise_error
        end
        @response = connection.send(request_method)
        connection.close
        log_nws_request
      end

      def request_headers
        {
          "User-Agent" => ENV.fetch("NWS_USER_AGENT", "testing"),
          "Content-Type" => "application/ld+json"
        }
      end

      def url
        "https://#{NWS_HOSTNAME}#{path}"
      end

      def log_nws_request
        request_body = nil
        metadata = nil

        if log_request && ENV.fetch("LOG_NWS_REQUESTS", "0")
          LogExternalRequestJob.perform_async(
            request_method,
            request_headers,
            url,
            request_body,
            response.headers.to_h,
            response.status,
            response.body,
            metadata
          )
        end
      end
    end
  end
end
