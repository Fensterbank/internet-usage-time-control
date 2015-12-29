class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :read_settings

  def read_settings
    @global_net_allowed = Setting.first.net_allowed
    if Ping.any?
      if Time.zone.now - Ping.last.created_at < 70
        @current_online_user = Ping.last.user.name
      end
    end
  end

  private
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def user_signed_in?
    current_user.present?
  end

  def require_login
    unless user_signed_in?
      redirect_to login_path
    end
  end

  helper_method :require_login
  helper_method :user_signed_in?

end
