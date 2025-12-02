require "rails_helper"

RSpec.describe Integration::Nws::Forecast do
  let(:service) { described_class.new(grid_id:, grid_x:, grid_y:) }

  let(:grid_id) { "ILN" }
  let(:grid_x) { 45 }
  let(:grid_y) { 42 }

  let(:hostname) { ::Integration::Nws::Api::NWS_HOSTNAME }
  let(:url) { "https://#{hostname}/gridpoints/#{grid_id}/#{grid_x}/#{grid_y}/forecast" }

  describe "#run" do
    subject(:run) { service.run }

    let(:get_forecast_request) {
      stub_request(:get, url).with(headers: {
        "Content-Type" => "application/ld+json",
        "User-Agent" => "testing"
      })
    }

    let(:forecast_response) {
      file_fixture("services/integration/nws/forecast_response.json").read
    }

    around do |example|
      with_modified_env NWS_USER_AGENT: "testing" do
        example.run
      end
    end

    before do
      get_forecast_request.to_return(
        status: 200,
        body: forecast_response
      )
    end

    it "uses the NWS gridpoints endpoint" do
      run
      expect(WebMock).to have_requested(:get, url).with(headers: {
        "User-Agent" => "testing",
        "Content-Type" => "application/ld+json"
      })
    end

    it "returns the forecast periods from the NWS forecast response" do
      expect(run["properties"]["periods"].size).to eq(14)
      expect(run["properties"]["periods"][0]).to include(
        "name" => "Today",
        "temperature" => 88,
        "temperatureUnit" => "F",
        "windSpeed" => "2 to 6 mph",
        "windDirection" => "E",
        "shortForecast" => "Mostly Sunny",
        "detailedForecast" => "Mostly sunny, with a high near 88. East wind 2 to 6 mph."
      )
    end
  end
end
