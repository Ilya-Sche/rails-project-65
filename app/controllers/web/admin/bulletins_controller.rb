# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def moderation
    @bulletins = Bulletin.includes(:category, :user).under_moderation.order(created_at: :desc)
  end

  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = Bulletin.all
                         .ransack(params[:q])
                         .result
                         .order(created_at: :desc)
                         .page(params[:page])
                         .per(10)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def publish
    @bulletin = Bulletin.find(params[:id])

    @bulletin.publish
    if @bulletin.save
      redirect_to admin_bulletins_path, notice: I18n.t('flash.publish', model: @bulletin.class.name)
    else
      redirect_to admin_bulletins_path, alert: I18n.t('flash.error')
    end
  end

  def reject
    @bulletin = Bulletin.find(params[:id])

    @bulletin.reject
    if @bulletin.save
      redirect_to admin_bulletins_path, notice: I18n.t('flash.reject', model: @bulletin.class.name)
    else
      redirect_to admin_bulletins_path, alert: I18n.t('flash.error')
    end
  end

  def archive
    @bulletin = Bulletin.find(params[:id])

    @bulletin.archive
    if @bulletin.save
      redirect_to admin_bulletins_path, notice: I18n.t('flash.archive', model: @bulletin.class.name)
    else
      redirect_to admin_bulletins_path, alert: I18n.t('flash.error')
    end
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end
end
