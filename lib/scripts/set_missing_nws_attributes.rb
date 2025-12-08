class SetMissingNwsAttributes
  def run
    Location.where(nws_grid_id: nil).find_each do |location|
      Locations::SetNwsLocationAttributes.new(location_id: location.id).run
    end
  end
end
