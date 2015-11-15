require 'minitest/unit'
require 'test_helper'
class TwitterApiTest < Minitest::Unit::TestCase
  def setup
    @api = TwitterApi.new
  end

  def test_valid_user
    tweets = @api.query_by_username('310cpsc')
    assert(tweets != nil,'tweets should not be nil')
    tweets = @api.query_by_username('@310cpsc')
    assert(tweets != nil, 'tweets should not be nil')
  end

  def test_invalid_user
    tweets = @api.query_by_username('jlf;ksajlaw092390209ra sd sdcsa cdsass3234242')
    assert_nil(tweets, 'tweets should be nil')
  end

  def test_tweets_have_places
    tweets = @api.query_by_username('310cpsc')
    tweets.each do |tweet|
      assert(tweet.place != nil, 'tweet did not have a place')
    end
  end
end