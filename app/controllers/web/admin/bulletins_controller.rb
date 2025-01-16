# frozen_string_literal: true

class Web::Admin::BulletinsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def admin
    @categories = Category.all
    @bulletins = Bulletin.includes(:category, :user).order(created_at: :desc)
  end

  def moderation
    @bulletins = Bulletin.includes(:category, :user).where(state: :under_moderation).order(created_at: :desc)
  end

  def index
    @bulletins = Bulletin.all
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true).page(params[:page])
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
  end

  def update
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.update(bulletin_params)
      redirect_to admin_bulletins_path, notice: I18n.t('flash.update', model: @bulletin.class.name)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bulletin = Bulletin.find(params[:id])
    @bulletin.destroy
    redirect_to admin_bulletins_path, notice: I18n.t('flash.destroy', model: @bulletin.class.name)
  end

  def send_for_moderation
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.send_for_moderation!(state: :under_moderation)
      redirect_to admin_bulletins_path, notice: I18n.t('flash.moderate', model: @bulletin.class.name)
    else
      redirect_to admin_bulletins_path, alert: I18n.t('flash.error')
    end
  end

  def publish
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.publish!(state: :published)
      redirect_to admin_bulletins_path, notice: I18n.t('flash.publish', model: @bulletin.class.name)
    else
      redirect_to admin_bulletins_path, alert: I18n.t('flash.error')
    end
  end

  def reject
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.reject!(state: :rejected)
      redirect_to admin_bulletins_path, notice: I18n.t('flash.reject', model: @bulletin.class.name)
    else
      redirect_to admin_bulletins_path, alert: I18n.t('flash.error')
    end
  end

  def archive
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.archive!(state: :archived)
      redirect_to admin_bulletins_path, notice: I18n.t('flash.archive', model: @bulletin.class.name)
    else
      redirect_to admin_bulletins_path, alert: I18n.t('flash.error')
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :state, images: [])
  end

  def authenticate_user!
    redirect_to new_user_path, alert: I18n.t('user.auth') unless current_user
  end

  def authorize_admin
    redirect_to root_path, alert: I18n.t('admin.not_auth') unless current_user&.user_admin?
  end
end
