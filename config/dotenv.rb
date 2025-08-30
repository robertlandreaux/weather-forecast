# frozen_string_literal: true

Dotenv.require_keys(
  "RAILS_MAX_THREADS",
  "REDIS_URL",
  "POSTGRES_USER",
  "POSTGRES_PASSWORD",
  "SENTRY_DSN"
)

if Rails.env.production?
  Dotenv.require_keys(
    "DATABASE_URL",
    "DATABASE_URL_WF_LOGS",
    "STATEMENT_TIMEOUT",
    "SENTRY_DSN"
  )
end
