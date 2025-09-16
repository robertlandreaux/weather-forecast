if Rails.env.development?
  Dotenv.require_keys(
    "GEOCODIO_API_KEY",
    "GEONAMES_USERNAME",
    "LOG_NWS_REQUESTS",
    "POSTGRES_PASSWORD",
    "POSTGRES_USER",
    "RAILS_MAX_THREADS",
    "REDIS_URL",
    "SENTRY_DSN"
  )
end

if Rails.env.test?
  Dotenv.require_keys(
    "GEONAMES_USERNAME",
    "LOG_NWS_REQUESTS",
    "RAILS_MAX_THREADS",
    "REDIS_URL",
    "TEST_PRIMARY_DATABASE_URL",
    "TEST_WF_LOGS_DATABASE_URL"
  )
end

if Rails.env.production?
  Dotenv.require_keys(
    "DATABASE_URL_WF_LOGS",
    "DATABASE_URL",
    "IDLE_IN_TRANSACTION_SESSION_TIMEOUT",
    "GEOCODIO_API_KEY",
    "GEONAMES_USERNAME",
    "LOG_NWS_REQUESTS",
    "SENTRY_DSN",
    "STATEMENT_TIMEOUT"
  )
end
