module ReservationsHelper
  def five_day_forecast
    response = OpenWeatherService.new.get_forecast
    forecast = {}
    if response["list"].present?
      response["list"].each do |x|
        key  = x['dt'] - x['dt'] % 86400
        date = DateTime.strptime(key.to_s, "%s")
        forecast[key] = [] unless forecast[key].present?
        forecast[key].push({date: date, weather: x.dig("weather", 0, "main"), temp: x.dig('main','temp')})
      end
    end
    forecast.each{ |key, val| forecast[key] = val[val.count/2] }
  end
end
