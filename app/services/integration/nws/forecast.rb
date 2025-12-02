module Integration
  module Nws
    class Forecast
      def initialize(grid_id:, grid_x:, grid_y:)
        @grid_id = grid_id
        @grid_x = grid_x
        @grid_y = grid_y
      end

      def run
        path = "/gridpoints/#{grid_id}/#{grid_x}/#{grid_y}/forecast"
        Integration::Nws::Api.new(request_method: "get", path:).parsed_response
      end

      private

      attr_reader :grid_id
      attr_reader :grid_x
      attr_reader :grid_y
    end
  end
end
