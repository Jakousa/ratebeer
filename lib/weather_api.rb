class WeatherApi
  def self.weather_in(city)
    city = city.downcase

    #places = Rails.cache.read(city)
    #return places if places

    weather = get_weather_in(city)
    #Rails.cache.write(city, places, expires_in: 1.week)
    weather
  end

  def self.get_weather_in(city)
    url = "https://api.apixu.com/v1/current.json?key=#{key}&q="

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    return nil if response["error"]

    icon_with_https = "https:#{response['current']['condition']['icon']}"
    wind_speed_in_meters_per_second = (response["current"]["wind_kph"] / 3.6).round(1)

    Weather.new({
      location: response["location"]["name"],
      icon: icon_with_https,
      wind_speed: wind_speed_in_meters_per_second,
      wind_direction: response["current"]["wind_dir"],
      temperature: response["current"]["temp_c"]
    })
  end

  def self.key
    raise "WEATHER_APIKEY env variable not defined" if Rails.application.credentials.WEATHER_APIKEY.nil?

    Rails.application.credentials.WEATHER_APIKEY
  end
end
