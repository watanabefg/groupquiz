# encoding:UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :authenticate

  def authenticate
    unless user_sign_in?
      redirect_to signin_path
    end
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_sign_in?
    return true if current_user
  end
end
