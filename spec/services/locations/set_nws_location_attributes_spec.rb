require "rails_helper"
require "shared_contexts/with_application_data"

RSpec.describe Locations::SetNwsLocationAttributes do
  include_context "with application data"

  let(:service) { described_class.new(location_id:) }

  let(:location_id) { location.id }

  let(:location) { TestProf::AnyFixture.cached(:us_location) }

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
        "gridId" => "ILN",
        "gridX" => 45,
        "gridY" => 42
      }
    }
    it "updates the location nws attributes" do
      expect { run }.to change { location.reload.nws_grid_id }.to("ILN")
        .and change { location.reload.nws_grid_x }.to(45)
        .and change { location.reload.nws_grid_y }.to(42)
    end
  end
end
