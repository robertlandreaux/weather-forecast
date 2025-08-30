# frozen_string_literal: true

if Rails.env.local?
  Dotenv.require_keys(
    "RAILS_MAX_THREADS",
    "REDIS_URL",
    "POSTGRES_USER",
    "POSTGRES_PASSWORD",
    "SENTRY_DSN",
    "GEOCODIO_API_KEY"
  )
end

if Rails.env.production?
  Dotenv.require_keys(
    "DATABASE_URL",
    "DATABASE_URL_WF_LOGS",
    "STATEMENT_TIMEOUT",
    "SENTRY_DSN",
    "GEOCODIO_API_KEY"
  )
end
