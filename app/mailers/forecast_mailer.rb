class ForecastMailer < ApplicationMailer
  def new_forecast_email(forecast)
    @forecast = forecast
    @location = forecast.location
    @user = forecast.user
    mail(
      to: user.email,
      subject: "#{forecast.date.strftime("%A, %b %d %Y")} Forecast for #{location.city}, #{location.state}"
    )
  end
end
