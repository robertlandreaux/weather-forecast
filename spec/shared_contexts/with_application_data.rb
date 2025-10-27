RSpec.shared_context "with application data" do
  before(:all) do
    @us_location = TestProf::AnyFixture.register(:us_location) do
      FactoryBot.create(:us_location)
    end
  end

  after(:all) do
    @us_location.reload
  end
end
