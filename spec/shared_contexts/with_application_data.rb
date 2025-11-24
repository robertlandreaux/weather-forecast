RSpec.shared_context "with application data" do
  before(:all) do
    @us_location = TestProf::AnyFixture.register(:us_location) do
      FactoryBot.create(:us_location)
    end

    @user_1 = TestProf::AnyFixture.register(:user_1) do
      FactoryBot.create(:user, full_name: "Jane Doe", email: "jane@example.com")
    end

    @user_2 = TestProf::AnyFixture.register(:user_2) do
      FactoryBot.create(:user, full_name: "John Smith", email: "john@example.com")
    end

    @forecast_us_location = TestProf::AnyFixture.register(:forecast_us_location) do
      FactoryBot.create(
        :forecast,
        location: @us_location,
        data: {
          "today" => "Partly Cloudy. High of 85°F.",
          "tonight" => "Clear. Low of 65°F."
        }
      )
    end
  end

  after(:all) do
    @us_location.reload
    @user_1.reload
    @user_2.reload
    @forecast_us_location.reload
  end
end
