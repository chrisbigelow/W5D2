class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception


  helper_method :current_user, :logged_in?

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def login(user)
    session[:session_token] = user.reset_session_token
  end

  def logout
    current_user.reset_session_token
    sesssion[:session_token] = nil
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end



end