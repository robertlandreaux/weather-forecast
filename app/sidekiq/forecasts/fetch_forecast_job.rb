module Forecasts
  class FetchForecastJob < ApplicationJob
    sidekiq_options queue: :nws, retry: false

    def perform(location_id)
      Forecasts::FetchForecastService.new(location_id:).run
    end
  end
end
