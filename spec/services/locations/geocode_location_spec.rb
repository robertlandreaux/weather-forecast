require "rails_helper"
require "ostruct"

RSpec.describe Locations::GeocodeLocation do
  let(:service) { described_class.new(location_id: location_id) }

  let(:location_id) { location.id }
  let(:location) { TestProf::AnyFixture.cached(:us_location) }

  describe "#run" do
    subject(:run) { service.run }

    let(:coordinates) { OpenStruct.new(coordinates: [1.0, 2.0]) }
    before do
      allow(Geocoder).to receive(:search).with(location.address_for_geocoding).and_return(
        [coordinates]
      )
    end

    it "updates the location with the latitude and longitude from the geocoding API" do
      expect { run }.to change { location.reload.latitude }.to(1.0)
        .and change { location.reload.longitude }.to(2.0)
    end

    context "when the geocoding API does not return any coordinates" do
      before do
        allow(Geocoder).to receive(:search).with(location.address_for_geocoding).and_return([])
        allow(Rails.logger).to receive(:info)
      end

      it "does not update the location" do
        run
        expect(location.reload.latitude).to be_nil
        expect(location.reload.longitude).to be_nil

        expect(Rails.logger).to have_received(:info)
          .with("No coordinates found for #{location.address_for_geocoding}")
      end
    end
  end
end
