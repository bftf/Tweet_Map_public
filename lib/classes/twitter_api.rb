require 'oauth'
class TwitterApi
  def initialize
    @base_url = 'https://api.twitter.com'
    #http://www.codecademy.com/courses/ruby-intermediate-en-rUwFe/0/1
    @consumer_key = OAuth::Consumer.new(
        Rails.application.secrets.twitter_key,
        Rails.application.secrets.twitter_key_secret
    )
    @access_token = OAuth::Token.new(
        Rails.application.secrets.twitter_access_tolken,
        Rails.application.secrets.twitter_access_tolken_secret
    )
  end

  def query_by_username(username)
    path = '/1.1/statuses/user_timeline.json'
    query = URI.encode_www_form('screen_name' => username)
    address = URI("#{@base_url}#{path}?#{query}")

    http = Net::HTTP.new address.host, address.port
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request = Net::HTTP::Get.new address.request_uri
    request.oauth! http, @consumer_key, @access_token

    # Issue the request and return the response.
    http.start
    response = http.request request
    if response.code == '200'
      hash = Parser.parse(response.body)
      filtered_hash = filter_for_location(hash)
      HashConverter.convert_to_tweets(filtered_hash)
    else
      nil
    end
  end



  def query_by_location(coords, radius, date)
    path = '/1.1/search/tweets.json'
    query = URI.encode_www_form('geocode' => "#{coords.latitude},#{coords.longitude},#{radius}mi",
    'count' => 100,
    'until' => date)
    address = URI("#{@base_url}#{path}?#{query}")

    http = Net::HTTP.new address.host, address.port
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request = Net::HTTP::Get.new address.request_uri
    request.oauth! http, @consumer_key, @access_token

    # Issue the request and return the response.
    http.start
    response = http.request request
    if response.code == '200'
      hash = Parser.parse(response.body)
      hash = hash['statuses']
      filtered_hash = filter_for_location(hash)
      HashConverter.convert_to_tweets(filtered_hash)
    else
      nil
    end
  end

  def find_location_coordinates(p_id)
    path = '/1.1/geo/id/'
    # query = URI.encode_www_form('place_id' => p_id)
    address = URI("#{@base_url}#{path}#{p_id}.json")
    http = Net::HTTP.new address.host, address.port
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request = Net::HTTP::Get.new address.request_uri
    request.oauth! http, @consumer_key, @access_token

    # Issue the request and return the response.
    http.start
    response = http.request request
    if response.code == '200'
      hash = Parser.parse(response.body)
      hash['bounding_box']['coordinates']
    else
      nil
    end
  end

  private
  def filter_for_location(to_filter)
    filtered = []
    i = 0
    to_filter.each do |element|
      if element['place'] != nil || element['geo'] != nil || element['coordinates'] != nil
        filtered[i] = element
        i = i + 1
      end
    end
    filtered
  end


end
