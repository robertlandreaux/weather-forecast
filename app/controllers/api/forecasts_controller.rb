module Api
  class ForecastsController < BaseController
    def forecast
      if existing_location.nil?
        new_location
      elsif existing_forecast.nil?
        fetch_forecast
      end

      render(
        json: response_json,
        status: :ok
      )
    end

    typed_params on: :forecast do
      param :city, type: :string
      param :state, type: :string
      param :zip_code, type: :string
      param :country_code, type: :string
    end

    private

    def existing_location
      @existing_location ||= begin
        location_attributes = {
          address_line_3: forecast_params[:city],
          address_line_4: forecast_params[:state]

        }

        location_attributes[:address_line_5] = forecast_params[:zip_code] if forecast_params[:zip_code].present?
        location_attributes[:country_code] = forecast_params[:country_code] if forecast_params[:country_code].present?
        Location.find_by(location_attributes)
      end
    end

    def existing_forecast
      @existing_forecast = Forecast.find_by(location: existing_location, date: Date.current)
    end

    def fetch_forecast
      Forecasts::FetchForecastJob.perform_async(existing_location.id)
    end

    def new_location
      @new_location ||= Locations::CreateLocationService.new(
          location_attributes: {
            city: forecast_params[:city],
            state: forecast_params[:state],
            zip_code: forecast_params[:zip_code],
            country_code: forecast_params[:country_code]
          }
        ).run
    end

    def response_message
      if existing_location.nil? || existing_forecast.nil?
        "Forecast will be available shortly."
      elsif existing_forecast
        "OK"
      end
    end

    def response_json
      location = existing_location || new_location

      response = {
        message: response_message,
        location: {
          city: location.address_line_3,
          state: location.address_line_4,
          zip_code: location.address_line_5,
          country_code: location.country_code
        }
      }

      if existing_forecast
        response[:forecast] = {
          date: existing_forecast.date.strftime("%A, %B %d"),
          today: existing_forecast.data["today"],
          tonight: existing_forecast.data["tonight"]
        }
      end

      response
    end

    def forecast_params
      params.permit(:city, :state, :zip_code, :country_code)
    end
  end
end
