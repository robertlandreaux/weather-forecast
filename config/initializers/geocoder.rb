Geocoder.configure(
  timeout: 3,
  lookup: :geocodio,
  language: :en,
  use_https: true,
  api_key: ENV["GEOCODIO_API_KEY"],
  cache: Redis.new,
  cache_options: {
    expiration: 2.days,
    prefix: "geocoder:"
  }
)
