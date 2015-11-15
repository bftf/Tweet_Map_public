class Coordinate
  attr_accessor :longitude, :latitude
  def initialize(lat, long)
    @latitude = lat
    @longitude = long
  end
end