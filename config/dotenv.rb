all_environments_required_keys = [
  "ADMIN_PASSWORD",
  "ADMIN_USERNAME",
  "GEONAMES_USERNAME",
  "LOG_NWS_REQUESTS",
  "PREFIXED_IDS_SALT",
  "RACK_SESSION_SECRET",
  "RAILS_MAX_THREADS",
  "REDIS_URL"
]
if Rails.env.development?
  Dotenv.require_keys(
    *all_environments_required_keys,
    "GEOCODIO_API_KEY",
    "POSTGRES_PASSWORD",
    "POSTGRES_USER",
    "NWS_USER_AGENT"
  )
end

if Rails.env.test?
  Dotenv.require_keys(
    *all_environments_required_keys,
    "TEST_DATABASE_URL_PRIMARY",
    "TEST_DATABASE_URL_WF_LOGS"
  )
end

if Rails.env.production?
  Dotenv.require_keys(
    *all_environments_required_keys,
    "DATABASE_URL_WF_LOGS",
    "DATABASE_URL_PRIMARY",
    "IDLE_IN_TRANSACTION_SESSION_TIMEOUT",
    "GEOCODIO_API_KEY",
    "LOG_NWS_REQUESTS",
    "SENTRY_DSN",
    "STATEMENT_TIMEOUT",
    "SKYLIGHT_AUTH_TOKEN",
    "NWS_USER_AGENT"
  )
end
