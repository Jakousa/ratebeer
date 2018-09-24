class BeermappingApi
  def self.places_in(city)
    city = city.downcase

    places = Rails.cache.read(city)
    return places if places

    places = get_places_in(city)
    Rails.cache.write(city, places, expires_in: 1.week)
    places
  end

  def self.place(place_id)
    place = Rails.cache.read(place_id)
    return place if place

    place = get_place(place_id)

    Rails.cache.write(place_id, place, expires_in: 1.day)
    place
  end

  def self.get_place(place_id)
    url = "http://beermapping.com/webservice/locquery/#{key}/#{place_id}"
    response = HTTParty.get url
    place = response.parsed_response["bmp_locations"]["location"]
    #return nil if place.is_a?(Hash) && place['id'] == "0"
    Place.new(place)
  end

  def self.get_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) && places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do |place|
      Place.new(place)
    end
  end

  def self.key
    raise "BEERMAPPING_APIKEY env variable not defined" if Rails.application.credentials.BEERMAPPING_APIKEY.nil?

    Rails.application.credentials.BEERMAPPING_APIKEY
  end
end
