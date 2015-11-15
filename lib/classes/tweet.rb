class Tweet
  attr_reader :text, :id_str, :created_at, :coordinates, :truncated, :geo, :id, :user, :place

  def initialize(tweet_hash = nil)
    if tweet_hash.nil?
      initialize_empty
    else
      initialize_not_empty(tweet_hash)
    end
  end

  private
  def initialize_empty
    @created_at = nil
    @id = nil
    @id_str = nil
    @text = nil
    @truncated = nil
    @user = nil
    @geo = nil
    @coordinates = nil
    @place = nil
  end

  def initialize_not_empty(tweet_hash)
    @created_at = tweet_hash['created_at']
    @id = tweet_hash['id']
    @id_str = tweet_hash['id_str']
    @text = tweet_hash['text']
    @truncated = tweet_hash['truncated']
    @user = TwitterUser.new(tweet_hash['user'])
    @coordinates = get_coordinates(tweet_hash)

  end

  def get_coordinates(hash)
    @lat_index = 0
    @long_index = 1
    if hash['coordinates'] != nil
      @lat_index = 1
      @long_index = 0
      create_coordinate(hash['coordinates'])
    elsif hash['geo'] != nil
      @lat_index = 1
      @long_index = 0
      create_coordinate(hash['geo'])
    else
      google = GoogleAPI.new
      address = create_address(hash['place'])
      coords = google.find_coordinates(address)
    end

  end

  def create_address(hash)
    "#{hash['full_name']},#{hash['country']}"
  end

  def create_coordinate(coord_hash)
    Coordinate.new(coord_hash['coordinates'][@lat_index], coord_hash['coordinates'][@long_index])
  end
end