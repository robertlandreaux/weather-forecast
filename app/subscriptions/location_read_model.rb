class LocationReadModel
  def call(event)
    case event
    when Locations::LocationCreated
      location_id = event.data[:location_id]
      Locations::GeocodeLocationJob.perform_async(location_id)
    end
  end
end
