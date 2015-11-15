require 'classes/google_api'
require 'classes/twitter_api'

class MapController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter do
    if (session[:user_name] == nil)
      redirect_to('/')
    end
  end

  # protect_from_forgery with: :exceptionrake routes
    def index
      if params.has_key?(:q)
        handle_input
      else if params.has_key?(:lat)
        handle_map_click
      else
        twitter_helper = TwitterApi.new
        @tweet_list = twitter_helper.query_by_username(session[:user_name]).to_json
      end
    end

  end
  def handle_input
    if(params.has_key?(:t))
      time = params[:t]
      time.gsub!("/", "-")
    else
      time = Time.now.strftime("%d-%m-%Y")
    end
    twitter_helper = TwitterApi.new
    if params[:q].start_with?( '@' )
      @tweet_list = twitter_helper.query_by_username(params[:q]).to_json
    else
      # @tweet_list.to_json
      google_helper = GoogleAPI.new
      coord = google_helper.find_coordinates(params[:q])
      @tweet_list = twitter_helper.query_by_location(coord, 5, time).to_json
    end

  end

  def handle_map_click
    if(params.has_key?(:t))
      time = params[:t]
      time.gsub!("/", "-")
    else
      time = Time.now.strftime("%d-%m-%Y")
    end
    coord_for_click = Coordinate.new(params[:lat],params[:lng])
    twitter_helper_for_click = TwitterApi.new
    @tweet_list = twitter_helper_for_click.query_by_location(coord_for_click, 5, time).to_json
    render :json => {
               :file_content => @tweet_list
           }
    a = 1
  end

end