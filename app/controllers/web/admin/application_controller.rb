# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  include AuthManager
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  allow_browser versions: :modern
  helper_method :user_signed_in?, :current_user

  def authenticate_user!
    redirect_to root_path, alert: I18n.t('user.auth') unless user_signed_in?
  end
end
