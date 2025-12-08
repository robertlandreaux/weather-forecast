require "rails_helper"
require "ostruct"

RSpec.describe Locations::GeocodeLocation do
  let(:service) { described_class.new(location_id: location_id) }

  let(:location_id) { location.id }
  let(:location) {
    FactoryBot.create(
      :us_location,
      latitude: nil,
      longitude: nil
    )
  }

  describe "#run" do
    subject(:run) { service.run }

    let(:coordinates) { OpenStruct.new(coordinates: [1.0, 2.0]) }
    let(:time_zone) { OpenStruct.new(name: "America/New_York") }
    before do
      allow(Geocoder).to receive(:search).with(location.address_for_geocoding).and_return(
        [coordinates]
      )
      allow(Timezone).to receive(:lookup).with(1.0, 2.0).and_return(time_zone)
    end

    it "updates the location with the latitude and longitude from the geocoding API" do
      expect { run }.to change { location.reload.latitude }.to(1.0)
        .and change { location.reload.longitude }.to(2.0)
    end

    it "updates location.time_zone with the return value of Timezone.lookup" do
      expect { run }.to change { location.reload.time_zone }
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

    context "when the location already has latitude and longitude" do
      let(:location) {
        FactoryBot.create(
          :us_location,
          latitude: 10.0,
          longitude: 20.0
        )
      }

      it "does not call the geocoding API" do
        run
        expect(Geocoder).not_to have_received(:search)
      end

      it "does not update the location" do
        expect { run }.not_to change { location.reload }
      end
    end

    context "when Timezone.lookup raises an error" do
      before do
        allow(Timezone).to receive(:lookup).and_raise(StandardError, "Some error")
        allow(Sentry).to receive(:capture_exception)
      end

      it "captures the exception with Sentry" do
        run
        expect(Sentry).to have_received(:capture_exception).with(instance_of(StandardError))
      end

      it "does not set the time_zone on the location" do
        run
        expect(location.reload.time_zone).to be_nil
      end

      it "still sets the latitude and longitude on the location" do
        run
        expect(location.reload.latitude).to eq(1.0)
        expect(location.reload.longitude).to eq(2.0)
      end
    end
  end
end
