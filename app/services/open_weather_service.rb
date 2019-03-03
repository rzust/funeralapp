class OpenWeatherService
  def initialize
    @client ||= Faraday.new do |builder|
      builder.use :http_cache, store: Rails.cache, logger: ActiveSupport::Logger.new(STDOUT)
      builder.use Faraday::CacheControl, cache_control: 'public, max-age=3600'
      builder.response :json, :content_type => /\bjson$/
      builder.adapter Faraday.default_adapter
    end
  end

  def get_forecast
    api_key  = Rails.application.credentials.dig(:open_weather, :key)
    response = @client.get "http://api.openweathermap.org/data/2.5/forecast?id=3196359&units=metric&APPID=#{api_key}"
    response.body
  end
end