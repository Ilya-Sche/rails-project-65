# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :set_bulletin, only: %i[send_for_moderation archive update destroy edit]
  before_action :authenticate_user!, except: %i[index show]
  before_action :authorize_bulletin!, only: %i[edit update destroy archive send_for_moderation]

  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = Bulletin.includes(:category, :user)
                         .published
                         .ransack(params[:q])
                         .result
                         .order(created_at: :desc)
                         .page(params[:page])
                         .per(10)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: I18n.t('admin.not_auth')
  end

  def new
    @bulletin = Bulletin.new
  end

  def edit; end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    if @bulletin.save
      redirect_to @bulletin, notice: I18n.t('flash.create', model: @bulletin.class.name)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: I18n.t('flash.update', model: @bulletin.class.name)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bulletin.destroy

    redirect_to bulletins_path, notice: I18n.t('flash.destroy', model: @bulletin.class.name)
  end

  def send_for_moderation
    @bulletin.send_for_moderation
    if @bulletin.save
      redirect_to profile_path, notice: I18n.t('flash.moderate', model: @bulletin.class.name)
    else
      redirect_to profile_path, alert: I18n.t('flash.error')
    end
  end

  def archive
    @bulletin.archive
    if @bulletin.save
      redirect_to profile_path, notice: I18n.t('flash.archive', model: @bulletin.class.name)
    else
      redirect_to profile_path, alert: I18n.t('flash.error')
    end
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end

  def authorize_bulletin!
    authorize @bulletin
  end
end
