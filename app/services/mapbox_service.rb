require "json"
require "open-uri"

class MapboxService
  def museums(lat, lng)
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{lng},#{lat}&access_token=#{ENV['MAPBOX_KEY']}"
    # url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{lat},#{lng}&access_token=pk.eyJ1IjoiYWxlY2lvZmlsaG8iLCJhIjoiY2wxa3Q2N2x1MDAxZTNibWhoOWQxYmVmciJ9.yB4Z70tffFFdjKWALsvmRg"
    data_serialized = URI.open(url).read
    museums = JSON.parse(data_serialized)
    # museums["features"].map { |museum| museum["text"] }
    data = {}
    museums['features'].each do |museum|
      data[museum['context'][0]['text']] = [] unless data[museum['context'][0]['text']]
      data[museum['context'][0]['text']] << museum['text']
    end
    data
  end
end
