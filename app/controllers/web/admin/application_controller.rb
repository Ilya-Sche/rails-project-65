# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  allow_browser versions: :modern
  helper_method :authorize_admin

  def authorize_admin
    redirect_to root_path, alert: I18n.t('admin.not_auth') unless current_user&.user_admin?
  end
end
