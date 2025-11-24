class ForecastMailer < ApplicationMailer
  def new_forecast(forecast, user)
    @forecast = forecast
    @location = forecast.location
    mail(
      to: user.email,
      subject: "#{forecast.date.strftime("%A, %b %d %Y")} Forecast for #{location.city}, #{location.state}"
    )
  end
end
