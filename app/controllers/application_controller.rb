class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user


  def logged_in?
    !current_user.nil?
  end
  helper_method :logged_in?

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to welcome_url
    end
  end
end
