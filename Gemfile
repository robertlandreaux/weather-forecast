source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.5"

gem "dotenv"
gem "pg"
gem "puma"
gem "rails"
gem "propshaft"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[windows jruby]

gem "faraday"
gem "faraday-retry"

gem "rails_event_store"

gem "rack-cors"

gem "redis"

gem "sidekiq"

gem "geocoder"

gem "sentry-ruby"
gem "sentry-rails"
gem "sentry-sidekiq"

gem "skylight"

gem "discard"

gem "timezone"

gem "rack-session"

gem "prefixed_ids"

group :development do
  gem "web-console"
end

group :development, :test do
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "standard"
  gem "standard-rails"
  gem "brakeman", require: false
  gem "byebug"
  gem "pry-byebug"
  gem "pry-rails"
end

group :test do
  gem "faker"
  gem "ruby_event_store-rspec"
  gem "test-prof"
  gem "webmock"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "climate_control"
end
