# frozen_string_literal: true

class PopulateLocations < ActiveRecord::Migration[8.1]
  US_CITIES = [
    {
      city: "New York",
      state: "NY",
      zip_code: "10001",
      country_code: "US"
    },
    {
      city: "Los Angeles",
      state: "CA",
      zip_code: "90001",
      country_code: "US"
    },
    {
      city: "Chicago",
      state: "IL",
      zip_code: "60601",
      country_code: "US"
    },
    {
      city: "Houston",
      state: "TX",
      zip_code: "77001",
      country_code: "US"
    },
    {
      city: "Phoenix",
      state: "AZ",
      zip_code: "85001",
      country_code: "US"
    },
    {
      city: "Philadelphia",
      state: "PA",
      zip_code: "19102",
      country_code: "US"
    },
    {
      city: "San Antonio",
      state: "TX",
      zip_code: "78201",
      country_code: "US"
    },
    {
      city: "San Diego",
      state: "CA",
      zip_code: "92101",
      country_code: "US"
    },
    {
      city: "Dallas",
      state: "TX",
      zip_code: "75201",
      country_code: "US"
    },
    {
      city: "San Jose",
      state: "CA",
      zip_code: "95101",
      country_code: "US"
    },
    {
      city: "Austin",
      state: "TX",
      zip_code: "73301",
      country_code: "US"
    },
    {
      city: "Jacksonville",
      state: "FL",
      zip_code: "32202",
      country_code: "US"
    },
    {
      city: "Fort Worth",
      state: "TX",
      zip_code: "76101",
      country_code: "US"
    },
    {
      city: "Columbus",
      state: "OH",
      zip_code: "43201",
      country_code: "US"
    }
  ]
  def up
    US_CITIES.each do |location|
      Location.find_or_create_by!(
        address_line_3: location[:city],
        address_line_4: location[:state],
        address_line_5: location[:zip_code],
        country_code: location[:country_code]
      )
    end
  end

  def down
    US_CITIES.each do |location|
      loc = Location.find_by(
        address_line_3: location[:city],
        address_line_4: location[:state],
        address_line_5: location[:zip_code],
        country_code: location[:country_code]
      )
      loc&.destroy
    end
  end
end
