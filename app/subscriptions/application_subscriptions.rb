class ApplicationSubscriptions
  def handlers
    {
      LocationReadModel.new => [Locations::LocationCreated]
    }
  end

  def call(event_store)
    handlers.each do |handler, events|
      event_store.subscribe(handler, to: events)
    end
  end
end
