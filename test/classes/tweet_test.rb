require 'minitest'
class TweetTest < MiniTest::Unit::TestCase
  def setup
    asd = 16
  end

  def test_makes_empty_object
    tweet = Tweet.new
    tweet.instance_variables.each do |variable|
      assert_nil(tweet.instance_variable_get(variable), "#{variable} should be nil")
    end
  end

  def test_makes_full_object

  end
end