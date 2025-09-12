require "rails_helper"

RSpec.describe Integration::Nws::Api do
  let(:api) { described_class.new(request_method:, path:, log_request:) }

  let(:request_method) { "get" }
  let(:path) { "/points/39.1762,-84.2418" }
  let(:log_request) { true }

  before do
    allow(LogExternalRequestJob).to receive(:perform_async)
  end

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

  let(:url) { "https://api.weather.gov/points/39.1762,-84.2418" }

  describe "#parsed_response" do
    subject(:parsed_response) { api.parsed_response }
    it "makes a request using the given request_method and path" do
      parsed_response
      expect(WebMock).to have_requested(:get, url).with(headers: {
        "User-Agent" => "testing",
        "Content-Type" => "application/ld+json"
      })
    end

    it "returns the parsed JSON" do
      expect(parsed_response).to include(
        "gridId" => "ILN",
        "gridX" => 45,
        "gridY" => 42
      )
    end
  end

  describe "response" do
    let(:response) { api.response }

    it "contains the full Faraday response object" do
      api.parsed_response
      expect(response).to be_an_instance_of(Faraday::Response)
      expect(response.status).to eq(200)
      expect(response.body).to be_a(String)
    end
  end
end
