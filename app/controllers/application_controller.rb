# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  allow_browser versions: :modern
  helper_method :user_signed_in?, :current_user
  before_action :set_locale

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end

  def user_admin?
    current_user&.user_admin?
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def user_not_authorized
    redirect_to root_path, alert: I18n.t('admin.not_auth')
  end
end
