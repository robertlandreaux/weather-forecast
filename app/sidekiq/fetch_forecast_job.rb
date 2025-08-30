# frozen_string_literal: true

class FetchForecastJob
  include Sidekiq::Job

  def perform
    # Integration::Nws::FetchForecastService.new.run
  end
end
