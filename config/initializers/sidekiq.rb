Sidekiq.strict_args!

Sidekiq.configure_server do |config|
  config.redis = {url: ENV["REDIS_URL"], size: 5}
end

Sidekiq.configure_client do |config|
  config.redis = {url: ENV["REDIS_URL"], size: 1}
end
