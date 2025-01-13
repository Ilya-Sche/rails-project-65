# frozen_string_literal: true

class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_user, :user_signed_in?

  def current_user
    @current_user ||= User.find_by(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def user_admin?
    current_user&.user_admin?
  end
end
