module Forecasts
  module Notifiers
    class NewForecast
      def initialize(forecast_id:)
        @forecast_id = forecast_id
      end

      def run
        users = Forecast.find(forecast_id).location.users

        BulkEnqueueMailers.new(
          mail_class: ForecastMailer,
          template: :new_forecast,
          mailer_args: users.map { |user| [forecast_id, user] }
        ).run
      end

      private

      attr_reader :forecast_id
    end
  end
end
