class ForecastReadModel
  def call(event)
    case event
    when Forecasts::ForecastCreated
      forecast_id = event.data[:forecast_id]
      Forecasts::Notifiers::NewForecast.new(forecast_id:).run
    end
  end
end
