require "rails_helper"

RSpec.describe Integration::Geocoder::GeocodeLocation do
  include_context "with application data"

  subject(:service) { described_class.new(location_id:) }

  let(:location) { fixture(:testlocation) }

  describe "#run" do
    subject(:run) { service.run }

    before do
      allow(Geocoder).to receive(:search).with(location.address_for_geocoding).and_return(
        {
          results: [
            {
              coordinates: [1.0, 2.0]
            }
          ]
        }
      )
    end

    it "updates the location with the latitude and longitude from the geocoding API" do
      debugger
      expect { run }.to change { location.reload.latitude }.from(nil).to(1.0)
        .and change { location.reload.longitude }.from(nil).to(2.0)
    end

    context "when the geocoding API does not return any coordinates" do
      before do
        allow(Geocoder).to receive(:search).with(location.address_for_geocoding).and_return(
          {
            results: [
              {
                coordinates: nil
              }
            ]
          }
        )
        allow(Rails.logger).to receive(:info)
      end

      it "does not update the location" do
        expect { run }.not_to change { location.reload.latitude }
          .and not_to change { location.reload.longitude }

        expect(Rails.logger).to have_received(:info)
          .with("No coordinates found for #{location.address_for_geocoding}")
      end
    end
  end
end
