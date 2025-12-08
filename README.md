# weather-forecast

This project fetches weather data forecasts from the United States National Weather Service [API](https://www.weather.gov/documentation/services-web-api) (NWS).

Currently only weather forecast data is only available for locations within the United States.

## Environment variables needed

See config/dotenv.rb for necessary environment variables.

## Automatic Formatting

This project uses [standard-rails](https://github.com/standardrb/standard-rails) as a linter and formatter. Run `rake standard:fix` to format the code automatically.

## Geocoding

You will need an API key from https://www.geocod.io/ in order to perform the geocoding on locations. In order to fetch NWS gridpoints, location latitude and longitude are required.

## Time zone lookups

app/sidekiq/forecasts/fetch_forecasts_job.rb is a scheduled job that fetches forecast data for all existing locations at 6 AM _of the location time zone_. This application uses the [Timezone gem](https://github.com/panthomakos/timezone) to fetch the time zone for a particular location. You will need to sign up for a free account at https://www.geonames.org/login and then set the GEONAMES_USERNAME to your username. 

## Background Processing

This project uses Sidekiq for background jobs and asynchronous processing. All Sidekiq jobs are located in app/sidekiq.

## Error Tracking

This project uses [Sentry](https://sentry.io/) for error tracking.

### Pre-requisites

Ensure that you have Redis and PostgreSQL installed and running. A Dockerfile and docker-compose.yml file will be coming to this project in the near future.

## Getting Started

The current ruby version is specified in the .ruby-version file. If you use rbenv to install Ruby, you can simply run `rbenv install` to install the version of Ruby that this project uses.

Then run `bundle install` to install the required Ruby gems.

To create the development and test, run:
`bin/rails db:create`
`bin/rails db:migrate`

If you want to populate your local environment with some sample locations, you can run:
`bin/rails data:migrate`
to run the data PopulateLocations migration in db/data/

This project uses the [data_migrate gem](https://github.com/ilyakatz/data-migrate) to manage data migrations rather than including data migrations within schema migrations, which are located in db/primary and db/wf_logs

This project stores all data in the primary database except for logs to the NWS API, which are stored in the wf_logs database.





