module Api
  class LocationsController < BaseController
    before_action :validate_location, only: [:create]

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
          city: location.address_line_3,
          state: location.address_line_4,
          zip_code: location.address_line_5,
          country_code: location.country_code
        },
        status: :created
      )
    end

    typed_params on: :create do
      param :location, type: :hash do
        param :city, type: :string
        param :state, type: :string
        param :zip_code, type: :string
        param :country_code, type: :string
      end
    end

    private

    def location_params
      params.require(:location).permit(:city, :state, :zip_code, :country_code)
    end

    def validate_location
      if location_params[:country_code] != "US"
        render(
          json: {error: "Only locations within the United States are supported."},
          status: :unprocessable_content
        )
      end
    end
  end
end
