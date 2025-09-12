require "rails_helper"

RSpec.describe Integration::Nws::Points do
  let(:service) { described_class.new(latitude:, longitude:) }

  let(:latitude) { 39.1762 }
  let(:longitude) { -84.2418 }

  let(:hostname) { ::Integration::Nws::Api::NWS_HOSTNAME }
  let(:url) { "https://#{hostname}/points/#{latitude},#{longitude}" }
  describe "#run" do
    subject(:run) { service.run }

    let(:get_points_request) {
      stub_request(:get, url).with(headers: {
        "Content-Type" => "application/ld+json",
        "User-Agent" => "testing"
      })
    }

    let(:points_response) {
      file_fixture("services/integration/nws/points_response.json").read
    }

    before do
      allow(ENV).to receive(:fetch).with("NWS_USER_AGENT", "testing").and_return("testing")
      get_points_request.to_return(
        status: 200,
        body: points_response
      )
    end

    it "uses the NWS points endpoint" do
      run
      expect(WebMock).to have_requested(:get, url).with(headers: {
        "User-Agent" => "testing",
        "Content-Type" => "application/ld+json"
      })
    end

    it "returns the grid attributes from the NWS points response" do
      expect(run).to include(
        "gridId" => "ILN",
        "gridX" => 45,
        "gridY" => 42
      )
    end
  end
end
