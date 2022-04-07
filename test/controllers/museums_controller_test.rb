require 'test_helper'

class MuseumsControllerTest < ActionDispatch::IntegrationTest
  test 'should return an error if missing lat and/or lng' do
    get '/museums'
    assert_response :bad_request
    parsed_response = JSON.parse(response.body)
    assert parsed_response['errors'].include?('Please provide lat and lng')
  end

  test 'should return an error when provided invalid lat and/or lng' do
    get '/museums?lat=100&lng=13'
    assert_response :unprocessed_entity
    parsed_response = JSON.parse(response.body)
    assert parsed_response['errors'].include?('lat must be between -90 and 90')
  end

  test 'lists nearby museums by postcode' do
    get '/museums/?lat=-23.565370&lng=-46.716790'
    assert_response :ok
    parsed_response = JSON.parse(response.body)
    assert parsed_response.keys.length == 3
    assert parsed_response['05503'].include?('Museu Biológico IB')
    assert parsed_response['05503'].include?('Museu Histórico Instituto Butantan')
    assert parsed_response['05503'].include?('Museu De Microbiologia-Instituto Butantan')
    assert parsed_response['05508'].include?('Instituto Oceanográfico (IO)')
    assert parsed_response['05506'].include?('Casa do Bandeirante')
  end
end
