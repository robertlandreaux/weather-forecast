module Api
  class LocationsController < ApplicationController
    def create
      location = Locations::CreateLocationService.new(
        location_attributes: {
          city: location_params[:city],
          state: location_params[:state],
          zip_code: location_params[:zip_code],
          country_code: location_params[:country_code]
        }
      ).run

      render(
        json: {
          id: location.prefix_id,
          city: location.city,
          state: location.state,
          zip_code: location.zip_code,
          country_code: location.country_code
        },
        status: :created
      )
    end

    private

    def location_params
      params.require(:location).permit(:city, :state, :zip_code, :country_code)
    end
  end
end
