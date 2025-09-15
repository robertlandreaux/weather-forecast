module Forecasts
  class FetchForecastJob
    include Sidekiq::Job

    def perform(location_id)
      Forecasts::FetchForecastService.new(location_id:).run
    end
  end
end
