module Api
  class LocationsController < ApplicationController
    def create
      location = Location.find_or_create_by!(
        address_line_3: params[:city],
        address_line_4: params[:state],
        address_line_5: params[:zip_code],
        country_code: params[:country_code]
      )

      event = LocationCreated.new(data: {location_id: location.id})
      event_store.publish(event, stream_name: "Location_#{location.id}", expected_version: :any)
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
  end
end
