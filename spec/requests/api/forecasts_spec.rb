require "swagger_helper"

RSpec.describe "Forecast API", type: :request do
  let(:username) { ENV["ADMIN_USERNAME"] }
  let(:password) { ENV["ADMIN_PASSWORD"] }
  let(:basic_auth) {
    ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
  }

  path "/api/forecast" do
    post("Fetches the current forecast") do
      tags "Forecast"
      consumes "application/json"
      security [{basic_auth: []}]
      parameter name: :Authorization, in: :header, type: :string, required: true, description: "Auth token"
      parameter name: :forecast, in: :body, schema: {
        type: :object,
        properties: {
          city: {type: :string},
          state: {type: :string},
          zip_code: {type: :string},
          country_code: {type: :string}
        },
        required: ["city", "state", "zip_code", "country_code"]
      }

      response "200", "forecast fetched" do
        let(:Authorization) { basic_auth }

        let(:forecast) {
          {
            city: "San Francisco",
            state: "CA",
            country_code: "USA",
            zip_code: "94103"
          }
        }
        run_test!
      end

      response "422", "invalid request" do
        let(:Authorization) { basic_auth }
        let(:forecast) { {city: "San Francisco", state: "CA"} }
        run_test!
      end

      response "401", "unauthorized" do
        let(:Authorization) { "invalid_token" }
        let(:forecast) {
          {
            city: "San Francisco",
            state: "CA",
            country_code: "USA",
            zip_code: "94103"
          }
        }
        run_test!
      end
    end
  end
end
