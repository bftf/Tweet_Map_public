class TwitterPlace
  attr_reader :name, :place_type, :url, :country, :full_name, :id, :country_code
  def initialize(location_hash)
    @id = location_hash['id']
    @url = location_hash['url']
    @place_type = location_hash['place_type']
    @name = location_hash['name']
    @full_name = location_hash['full_name']
    @country_code = location_hash['country_code']
    @country = location_hash['country']
  end
end