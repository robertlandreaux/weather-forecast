require "rails_helper"
RSpec.describe Locations::GeocodeLocationJob do
  let(:job) { described_class.new }

  describe "#perform" do
    subject(:perform) { job.perform(location_id) }

    let(:location_id) { 2 }

    let(:geocode_location) { instance_double(Locations::GeocodeLocation, run: true) }

    before do
      allow(Locations::GeocodeLocation).to receive(:new)
        .and_return(geocode_location)
    end

    it "uses Locations::GeocodeLocation#run" do
      perform
      expect(Locations::GeocodeLocation).to have_received(:new)
        .with(location_id:)
      expect(geocode_location).to have_received(:run)
    end
  end
end
