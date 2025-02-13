# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    user = find_or_initialize_user(auth)

    if user.save
      sign_in(user)
      redirect_to profile_path, notice: I18n.t('user.entered')
    else
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: I18n.t('user.logged_out')
  end

  private

  def find_or_initialize_user(auth)
    user = User.find_or_initialize_by(email: auth[:info][:email].downcase)
    user.name = auth[:info][:name]
    user.save
    user
  end
end
