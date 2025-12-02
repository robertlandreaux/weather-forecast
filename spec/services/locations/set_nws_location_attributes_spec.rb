require "rails_helper"

RSpec.describe Locations::SetNwsLocationAttributes do
  include_context "with application data"

  let(:service) { described_class.new(location_id:) }

  let(:location_id) { location.id }

  let(:location) { TestProf::AnyFixture.cached(:us_location_1) }

  describe "#run" do
    subject(:run) { service.run }

    before do
      allow(Integration::Nws::Points).to receive(:new).and_return(nws_points)
    end

    let(:nws_points) {
      instance_double(Integration::Nws::Points, run: nws_grid)
    }

    let(:nws_grid) {
      {
        "properties" => {
          "gridId" => "ILN",
          "gridX" => 45,
          "gridY" => 42
        }
      }
    }
    it "updates the location nws attributes" do
      expect { run }.to change { location.reload.nws_grid_id }.to("ILN")
        .and change { location.reload.nws_grid_x }.to(45)
        .and change { location.reload.nws_grid_y }.to(42)
    end

    context "when location is missing coordinates" do
      let(:location_missing_lat_and_long) {
        FactoryBot.create(:us_location, latitude: nil, longitude: nil)
      }

      let(:location_id) { location_missing_lat_and_long.id }

      it "raises LocationMissingCoordinates error" do
        expect { run }.to raise_error(
          Locations::SetNwsLocationAttributes::LocationMissingCoordinates,
          "Location must have latitude and longitude set"
        )
      end
    end
  end
end
