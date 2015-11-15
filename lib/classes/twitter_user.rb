class TwitterUser
  #note: this is not all the attributes that a user can have. Can add more as needed
  attr_reader :name, :screen_name, :id
  def initialize(user_hash)
    @id = user_hash['id']
    @name = user_hash['name']
    @screen_name = user_hash['screen_name']
  end
end