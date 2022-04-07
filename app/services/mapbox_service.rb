require "json"
require "open-uri"

class MapboxService
  def build_museums_response(lat, lng)
    museums = fetch_data(lat, lng)
    response = {}
    museums['features'].each do |museum|
      postcode = museum['context'][0]['text']
      response[postcode] = [] unless response[postcode]
      response[postcode] << museum['text']
    end
    response
  end

  private

  def fetch_data(lat, lng)
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{lng},#{lat}&access_token=#{ENV['MAPBOX_KEY']}"
    data_serialized = URI.open(url).read
    JSON.parse(data_serialized)
  end
end
