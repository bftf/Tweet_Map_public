class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(username: session[:user_name]) if session[:user_name]

  end
  helper_method :current_user

  def login_required
    redirect_to('/') if (session[:user_name] == nil)
  end

end
