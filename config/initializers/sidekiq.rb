Sidekiq.strict_args!

Sidekiq.configure_server do |config|
  config.redis = {url: ENV["REDIS_URL"]}
  config.capsule("nws") do |cap|
    cap.concurrency = 1
    cap.queues = %w[nws]
  end

  config.capsule("geocoding") do |cap|
    cap.concurrency = 1
    cap.queues = %w[geocoding]
  end
end

Sidekiq.configure_client do |config|
  config.redis = {url: ENV["REDIS_URL"]}
end
