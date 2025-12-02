require "rails_helper"

RSpec.describe Api::ForecastsController, type: :controller do
  include BasicAuthHelper

  describe "POST #forecast" do
    before do
      allow(Locations::CreateLocationService).to receive(:new).and_return(create_location_service)
      allow(Forecasts::FetchForecastJob).to receive(:perform_async)

      travel_to(Date.new(2025, 11, 28))
    end

    let(:new_location) { FactoryBot.build(:us_location) }

    let(:create_location_service) {
      instance_double(Locations::CreateLocationService, run: new_location)
    }

    let(:valid_params) do
      {
        city: "Macon",
        state: "GA",
        zip_code: "31201",
        country_code: "US"
      }
    end

    let(:the_request) { post :forecast, params: valid_params }

    context "when authenticated" do
      before do
        http_login
      end

      context "when location does not exist" do
        it "returns a message about the location creation." do
          the_request

          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)
          expect(json_response["message"]).to eq("Forecast will be available shortly.")
        end

        it "uses Locations::CreateLocationService#run" do
          the_request
          expect(Locations::CreateLocationService).to have_received(:new).with(
            location_attributes: {
              city: "Macon",
              state: "GA",
              zip_code: "31201",
              country_code: "US"
            }
          )
          expect(create_location_service).to have_received(:run)
        end
      end

      context "when location exists but forecast does not" do
        let!(:location) do
          Location.create!(
            address_line_3: "Macon",
            address_line_4: "GA",
            address_line_5: "31201",
            country_code: "US"
          )
        end

        it "returns message indicating forecast will be available shortly" do
          the_request

          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)
          expect(json_response["message"]).to eq("Forecast will be available shortly.")
        end

        it "uses Forecasts::FetchForecastJob" do
          the_request
          expect(Forecasts::FetchForecastJob).to have_received(:perform_async).with(location.id)
        end
      end

      context "when both location and forecast exist" do
        let!(:location) do
          Location.create!(
            address_line_3: "Macon",
            address_line_4: "GA",
            address_line_5: "31201",
            country_code: "US"
          )
        end

        let!(:forecast) do
          Forecast.create!(
            location: location,
            date: Date.new(2025, 11, 28),
            data: {today: "Sunny. High of 90.", tonight: "Clear. Low of 70."}
          )
        end

        it "retrieves the existing forecast successfully" do
          the_request

          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)

          expect(json_response).to include(
            "message" => "OK",
            "location" => hash_including(
              "city" => "Macon",
              "state" => "GA",
              "zip_code" => "31201",
              "country_code" => "US"
            ),
            "forecast" => hash_including(
              "date" => "Friday, November 28",
              "today" => "Sunny. High of 90.",
              "tonight" => "Clear. Low of 70."
            )
          )
        end
      end
    end

    context "when not authenticated" do
      it "returns a 401 Unauthorized response" do
        the_request

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
