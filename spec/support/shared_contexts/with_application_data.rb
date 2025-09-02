RSpec.configure do |config|
  config.before(:suite) do
    @us_location = TestProf::AnyFixture.register(:us_location) do
      FactoryBot.create(:us_location)
    end
  end
end
