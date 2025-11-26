module Forecasts
  class FetchForecastsJob < ::ApplicationJob
    sidekiq_options queue: :forecasts, retry: false

    TARGET_HOUR = 6

    def run
      locations = Location.where(time_zone: time_zones).pluck(:id).zip

      FetchForecastJob.perform_bulk(locations)
    end

    private

    def time_zones
      utc_now = Time.now.utc

      TZInfo::Timezone.all.filter do |zone|
        local_time_in_zone = zone.utc_to_local(utc_now)
        (local_time_in_zone.hour == TARGET_HOUR) ? zone.name : false
      end
    end
  end
end
