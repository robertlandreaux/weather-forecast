module Forecasts
  module Notifiers
    class ForecastCreated < RailsEventStore::Event
      def initialize(forecast_id:)
        @forecast_id = forecast_id
      end

      def run
        forecast = Forecast.find(forecast_id)
        ForecastMailer.new_forecast(forecast).deliver_later
      end

      private

      attr_reader :forecast_id
    end
  end
end
