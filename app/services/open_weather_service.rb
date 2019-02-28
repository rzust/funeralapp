class OpenWeatherService

  def get_forecast
    api_key = Rails.application.credentials[:open_weather][:key]
    @client  = Faraday.new
    response = @client.get("http://api.openweathermap.org/data/2.5/forecast?id=3196359&units=metric&APPID=#{api_key}")
  end

end