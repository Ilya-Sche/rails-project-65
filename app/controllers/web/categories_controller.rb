# frozen_string_literal: true

class Web::CategoriesController < ApplicationController
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
      redirect_to categories_path, notice: I18n.t('category.created')
    else
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to web_category_path(@category), notice: I18n.t('category.updated')
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to web_categories_path, notice: I18n.t('category.destroyed')
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
