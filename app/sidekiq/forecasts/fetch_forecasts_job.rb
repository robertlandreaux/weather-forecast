module Forecasts
  class FetchForecastsJob < ::ApplicationJob
    sidekiq_options queue: :nws, retry: false

    TARGET_HOUR = 6

    def perform
      locations = Location
        .where(time_zone: time_zones)
        .where.not(nws_grid_id: nil)
        .pluck(:id).zip

      FetchForecastJob.perform_bulk(locations)
    end

    private

    def time_zones
      utc_now = Time.now.utc

      TZInfo::Timezone.all.filter { |zone|
        zone.name.start_with?("America/")
      }.filter { |zone|
        local_time_in_zone = zone.utc_to_local(utc_now)
        (local_time_in_zone.hour == TARGET_HOUR) ? zone.name : false
      }.map(&:name)
    end
  end
end
