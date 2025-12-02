RSpec.shared_context "with application data" do
  before(:all) do
    @us_location_1 = TestProf::AnyFixture.register(:us_location_1) do
      FactoryBot.create(
        :location,
        address_line_3: "Cincinnati",
        address_line_4: "OH",
        address_line_5: "45202",
        country_code: "US",
        latitude: 39.1031,
        longitude: -84.5120,
        nws_grid_id: "XYZ",
        nws_grid_x: 1,
        nws_grid_y: 2
      )
    end

    @us_location_2 = TestProf::AnyFixture.register(:us_location_2) do
      FactoryBot.create(
        :location,
        address_line_3: "Los Angeles",
        address_line_4: "CA",
        address_line_5: "90001",
        country_code: "US",
        latitude: 34.0522,
        longitude: -118.2437,
        nws_grid_id: "ABC",
        nws_grid_x: 3,
        nws_grid_y: 4
      )
    end

    @user_1 = TestProf::AnyFixture.register(:user_1) do
      FactoryBot.create(:user, full_name: "Jane Doe", email: "jane@example.com")
    end

    @user_2 = TestProf::AnyFixture.register(:user_2) do
      FactoryBot.create(:user, full_name: "John Smith", email: "john@example.com")
    end

    @forecast_1_us_location = TestProf::AnyFixture.register(:forecast_1_us_location) do
      FactoryBot.create(
        :forecast,
        location: @us_location_1,
        data: {
          "today" => "Partly Cloudy. High of 85°F.",
          "tonight" => "Clear. Low of 65°F."
        }
      )
    end

    @forecast_2_us_location = TestProf::AnyFixture.register(:forecast_2_us_location) do
      FactoryBot.create(
        :forecast,
        location: @us_location_2,
        data: {
          "today" => "Sunny. High of 75°F.",
          "tonight" => "Clear. Low of 55°F."
        }
      )
    end
  end

  after(:all) do
    @us_location_1.reload
    @us_location_2.reload
    @user_1.reload
    @user_2.reload
    @forecast_1_us_location.reload
    @forecast_2_us_location.reload
  end
end
