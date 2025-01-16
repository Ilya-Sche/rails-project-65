# frozen_string_literal: true

class Web::Admin::CategoriesController < ApplicationController
  before_action :authorize_admin

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: I18n.t('category.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: I18n.t('flash.update', model: @bulletin.class.name)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path, notice: I18n.t('flash.destroy', model: @bulletin.class.name)
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def authorize_admin
    redirect_to root_path, alert: I18n.t('admin.not_auth') unless current_user&.user_admin?
  end
end
