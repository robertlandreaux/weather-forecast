module Forecasts
  module Notifiers
    class NewForecast
      def initialize(forecast_id:)
        @forecast_id = forecast_id
      end

      def run
        forecast = Forecast.find(forecast_id)

        forecast.location.users.each do |user|
          ForecastMailer.new_forecast(forecast, user).deliver_later
        end
      end

      private

      attr_reader :forecast_id
    end
  end
end
