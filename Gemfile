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

gem "rack-cors"

gem "redis"

gem "sidekiq"

gem "sentry-ruby"
gem "sentry-rails"
gem "sentry-sidekiq"

group :development, :test do
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "standard"
  gem "standard-rails"
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "brakeman", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "faker"
end
