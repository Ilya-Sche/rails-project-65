# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :authorize_admin

  def authorize_admin
    redirect_to root_path, alert: I18n.t('admin.not_auth') unless current_user&.admin?
  end
end
