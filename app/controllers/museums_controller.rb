class MuseumsController < ApplicationController
  lat = params[:lat]
  lng = params[:lng]
  MapboxService.new.museums(lat, lng)
end
