class HashConverter
  def self.convert_to_tweets(tweet_hash)
    tweet_list = []
    i = 0
    tweet_hash.each do |component|
      tweet_list[i] = Tweet.new(component)
      i = i + 1
    end
    return tweet_list
  end
end