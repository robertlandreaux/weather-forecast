require "rails_helper"

RSpec.describe Location, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:country_code) }

    context "when country_code is US" do
      let(:country_code) { "US" }

      context "when address_line_3, address_line_4, and address_line 5 are blank" do
        subject(:us_location) { FactoryBot.build(:location, country_code:) }

        it "returns error messages" do
          us_location.validate
          expect(us_location.errors.messages[:base]).to include(
            "City can't be blank",
            "State can't be blank",
            "Zip Code can't be blank"
          )
        end
      end
    end
  end

  describe "#city" do
    subject(:us_location) { FactoryBot.build(:location, country_code: "US", address_line_3: "New Orleans") }

    it "returns address_line_3" do
      expect(us_location.city).to eq("New Orleans")
    end
  end

  describe "#state" do
    subject(:us_location) { FactoryBot.build(:location, country_code: "US", address_line_4: "LA") }

    it "returns address_line_4" do
      expect(us_location.state).to eq("LA")
    end
  end

  describe "#zip_code" do
    subject(:us_location) { FactoryBot.build(:location, country_code: "US") }
  end

  describe "#address_for_geocoding" do
    subject(:location) {
      FactoryBot.build(
        :location,
        address_line_3: "New Orleans",
        address_line_4: "LA",
        address_line_5: "70124",
        country_code: "US"
      )
    }

    it "returns a concatenation of address line 3, 4, and 5" do
      expect(location.address_for_geocoding).to eq("New Orleans, LA, 70124")
    end
  end
end
