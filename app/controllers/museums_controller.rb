class MuseumsController < ApplicationController
  lat = params[:lat]
  lng = params[:lng]
  coordinates = validate_params(params[:lat], params[:lng])
  if coordinates[:valid]
  end
  MapboxService.new.museums(coordinates[:lat], coordinates[:lng])

  private

  def validate_params(lat, lng)
    valid_lat = lat.present? && lat.to_f.between?(-90, 90)
    valid_lng = lng.present? && lng.to_f.between?(-180, 180)
    return { valid: true, lat: lat, lng: lng, status: :ok } if valid_lat && valid_lng

    build_error_messages(lat, lng, valid_lat, valid_lng)
  end

  def build_error_messages(lat, lng, valid_lat, valid_lng)
    errors = []
    if lat.nil? || lng.nil?
      status = :bad_request
      errors << 'Please provide lat and lng'
    else
      status = :unprocessed_entity
      errors << 'lat must be between -90 and 90' unless valid_lat
      errors << 'lng must be between -180 and 180' unless valid_lng
    end
    { valid: false, errors: errors, status: status }
  end

end
