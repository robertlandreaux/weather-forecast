module Scripts
  class GeocodeLocations
    def run
      Location.where(latitude: nil, longitude: nil).find_each do |location|
        Locations::GeocodeLocation.new(location_id: location.id).run
      end
    end
  end
end
