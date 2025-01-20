# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @bulletins = Bulletin.includes(:category, :user).where(state: :published).order(created_at: :desc).page(params[:page]).per(10)
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = Bulletin.new
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    if @bulletin.save
      redirect_to @bulletin, notice: I18n.t('flash.create', model: @bulletin.class.name)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: I18n.t('flash.update', model: @bulletin.class.name)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bulletin = Bulletin.find(params[:id])
    @bulletin.destroy
    return unless @bulletin.destroy

    redirect_to bulletins_path, notice: I18n.t('flash.destroy', model: @bulletin.class.name)
  end

  def send_for_moderation
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.send_for_moderation!
      redirect_to profile_path, notice: I18n.t('flash.moderate', model: @bulletin.class.name)
    else
      redirect_to profile_path, alert: I18n.t('flash.error')
    end
  end

  def archive
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.archive!
      redirect_to profile_path, notice: I18n.t('flash.archive', model: @bulletin.class.name)
    else
      redirect_to profile_path, alert: I18n.t('flash.error')
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :state, images: [])
  end

  def authenticate_user!
    redirect_to root_path, alert: I18n.t('user.auth') unless current_user
  end
end
