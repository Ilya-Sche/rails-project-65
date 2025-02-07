# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
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
      redirect_to admin_categories_path, notice: I18n.t('flash.update', model: @category.class.name)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.bulletins.exists?
      redirect_to admin_categories_path, alert: I18n.t('category.referenced')
    else
      @category.destroy
      redirect_to admin_categories_path, notice: I18n.t('flash.destroy', model: @category.class.name)
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
