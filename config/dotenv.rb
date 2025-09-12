if Rails.env.local?
  Dotenv.require_keys(
    "RAILS_MAX_THREADS",
    "REDIS_URL",
    "POSTGRES_USER",
    "POSTGRES_PASSWORD",
    "SENTRY_DSN",
    "GEOCODIO_API_KEY",
    "LOG_NWS_REQUESTS",
    "TEST_PRIMARY_DATABASE_URL",
    "TEST_WF_LOGS_DATABASE_URL"
  )
end

if Rails.env.production?
  Dotenv.require_keys(
    "DATABASE_URL",
    "DATABASE_URL_WF_LOGS",
    "STATEMENT_TIMEOUT",
    "SENTRY_DSN",
    "GEOCODIO_API_KEY",
    "LOG_NWS_REQUESTS"
  )
end
