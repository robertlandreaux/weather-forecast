require "rails_helper"

RSpec.describe Locations::SetNwsLocationAttributesJob do
  let(:job) { described_class.new }

  describe "#perform" do
    subject(:perform) { job.perform(location_id) }

    let(:location_id) { 1 }

    before do
      allow(Locations::SetNwsLocationAttributes).to receive(:new).and_return(set_nws_location_attributes)
    end

    let(:set_nws_location_attributes) { instance_double(Locations::SetNwsLocationAttributes, run: true) }

    it "uses Locations::SetNwsLocationAttributes#run" do
      perform
      expect(Locations::SetNwsLocationAttributes).to have_received(:new).with(location_id:)
      expect(set_nws_location_attributes).to have_received(:run)
    end
  end
end
