class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :authenticate

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end   

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end 

  def authenticate
    unless current_user
      deny_access
      return false
    end
  end

  def deny_access
    redirect_to login_path, :notice => "Please sign in to access this page"
  end

end
