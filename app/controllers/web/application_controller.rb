# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include AuthManager
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  helper_method :user_signed_in?, :current_user

  def authenticate_user!
    redirect_to root_path, alert: I18n.t('user.auth') unless user_signed_in?
  end

  private

  def user_not_authorized
    redirect_to root_path, alert: I18n.t('admin.not_auth')
  end
end
