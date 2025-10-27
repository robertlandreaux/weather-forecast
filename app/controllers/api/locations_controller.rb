module Api
  class LocationsController < ApplicationController
    def create
      location = Locations::CreateLocationService.new(location_attributes: location_params).run

      render(
        json: {
          id: location.prefixed_id,
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
