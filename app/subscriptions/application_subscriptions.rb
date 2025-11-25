class ApplicationSubscriptions
  def handlers
    {
      LocationReadModel.new => [Locations::LocationCreated],
      ForecastReadModel.new => [Forecasts::ForecastCreated]
    }
  end

  def call(event_store)
    handlers.each do |handler, events|
      event_store.subscribe(handler, to: events)
    end
  end
end
