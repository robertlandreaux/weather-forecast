Sidekiq.strict_args!

Sidekiq.configure_server do |config|
  config.redis = {url: ENV["REDIS_URL"]}
  config.capsule("single_thread") do |cap|
    cap.concurrency = 1
    cap.queues = %w[nws geocoding]
  end
end

Sidekiq.configure_client do |config|
  config.redis = {url: ENV["REDIS_URL"]}
end
