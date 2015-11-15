require 'oauth'
require 'open-uri'
class GoogleAPI
  def initialize
    @base_url = 'https://maps.googleapis.com/maps/api/geocode/json'
    @key = Rails.application.secrets.google_api_key
  end

  def find_coordinates(address)
    query = URI.encode_www_form('address' => address)
    address = URI("#{@base_url}?#{query}&key=#{@key}")

    response = open(address).read

    hash = Parser.parse(response)
    get_coordinate(hash)
  end

  private
  def get_coordinate(hash)
    lat = hash['results'][0]['geometry']['location']['lat']
    long = hash['results'][0]['geometry']['location']['lng']
    Coordinate.new(lat,long)
  end
end