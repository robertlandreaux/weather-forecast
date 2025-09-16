FactoryBot.define do
  factory :location do
    factory :us_location do
      address_line_1 { Faker::Address.street_address }
      address_line_2 { Faker::Address.secondary_address }
      address_line_3 { Faker::Address.city }
      address_line_4 { Faker::Address.state_abbr }
      address_line_5 { Faker::Address.zip_code }
      address_line_6 {}
      country_code { "US" }
      latitude { nil }
      longitude { nil }
      nws_grid_id { Faker::Restaurant.name }
      nws_grid_x { rand(1..100) }
      nws_grid_y { rand(1..100) }
    end

    factory :it_location do
      address_line_1 { "Via Calepina 28" }
      address_line_2 { nil }
      address_line_3 { "Trento" }
      address_line_4 { nil }
      address_line_5 { 38122 }
      address_line_6 {}
      country_code { "IT" }
      latitude { nil }
      longitude { nil }
    end
  end
end
