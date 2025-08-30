require "rails_helper"
RSpec.describe Integration::Geocoder::GeocodeLocationJob, type: :job do
  subject(:job) { described_class.new }

  describe "#perform" do
    subject(:perform) { job.perform(location_id) }

    let(:location_id) { 2 }

    let(:geocode_location) { instance_double(Integration::Geocoder::GeocodeLocation, run: true) }

    before do
      allow(Integration::Geocoder::GeocodeLocation).to receive(:new)
        .and_return(geocode_location)
    end

    it "uses Integration::Geocoder::GeocodeLocation#run" do
      perform
      expect(Integration::Geocoder::GeocodeLocation).to have_received(:new)
        .with(location_id:)
      expect(geocode_location).to have_received(:run)
    end
  end
end
