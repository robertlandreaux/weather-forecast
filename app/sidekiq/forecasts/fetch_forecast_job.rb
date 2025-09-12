module Forecasts
  class FetchForecastJob
    include Sidekiq::Job

    def perform
      # Integration::Nws::FetchForecastService.new.run
    end
  end
end
