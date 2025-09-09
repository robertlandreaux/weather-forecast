module Integration
  module Nws
    class Forecast
      def initialize(grid_id:, grid_x:, grid_y:)
        @grid_id = grid_id
        @grid_x = grid_x
        @grid_y = grid_y
      end

      def run
        path = "/gridpoints/#{grid_id}/#{grid_x}/#{grid_y}"
        Integration::Nws::Api.new(method: get, path:).run
      end

      private

      attr_reader :grid_id
      attr_reader :grid_x
      attr_reader :grid_y
    end
  end
end
