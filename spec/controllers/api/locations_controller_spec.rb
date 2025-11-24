require "rails_helper"

RSpec.describe Api::LocationsController, type: :controller do
  describe "POST #create" do
    before do
      allow(Locations::CreateLocationService).to receive(:new).and_call_original
    end

    let(:location_params) do
      {
        location: {
          city: "San Francisco",
          state: "CA",
          zip_code: "94103",
          country_code: "US"
        }
      }
    end

    subject(:the_request) do
      post :create, params: location_params
    end

    it "creates a new location and returns the location data" do
      expect {
        the_request
      }.to change(Location, :count).by(1)

      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)

      expect(json_response["city"]).to eq("San Francisco")
      expect(json_response["state"]).to eq("CA")
      expect(json_response["zip_code"]).to eq("94103")
      expect(json_response["country_code"]).to eq("US")
      expect(json_response).to have_key("id")
    end

    it "uses Locations::CreateLocationService" do
      the_request
      expect(Locations::CreateLocationService).to have_received(:new).with(location_attributes: {
        city: "San Francisco",
        state: "CA",
        zip_code: "94103",
        country_code: "US"
      })
    end
  end
end
