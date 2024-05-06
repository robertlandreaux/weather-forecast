source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

gem 'dotenv'
gem 'pg'
gem 'puma'
gem 'rails'
gem 'sprockets-rails'

group :development, :test do
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'pry-stack_explorer'
  gem 'rspec-rails'
  gem 'rubocop', require: false
end

group :development do
  gem 'better_errors'
  gem 'bootsnap', require: false
  gem 'listen'
  gem 'web-console'
end

group :test do
  gem 'faker'
end
