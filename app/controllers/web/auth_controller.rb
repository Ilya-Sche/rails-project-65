# frozen_string_literal: true

class Web::AuthController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']

    session[:user_id] = auth['uid']
    session[:user_name] = auth['info']['name']
    session[:user_email] = auth['info']['email']

    redirect_to profile_path, notice: I18n.t('user.entered')
  end

  def destroy
    session[:user_id] = nil
    session[:user_name] = nil
    session[:user_email] = nil
    redirect_to root_path, notice: I18n.t('user.logged_out')
  end
end
