# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    authenticate_user!
    @bulletins = current_user.bulletins.page(params[:page]).per(10)
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def create
    @user = User.find_or_create_by(email: user_params[:email]) do |u|
      u.name = user_params[:name]
    end

    if @user.persisted?
      session[:user_id] = @user.id
      redirect_to root_path, notice: I18n.t('user.entered')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def authenticate_user!
    redirect_to root_path, alert: I18n.t('user.auth') unless user_signed_in?
  end
end
