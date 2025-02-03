# frozen_string_literal: true

class Web::CategoriesController < Web::ApplicationController
  def index
    @categories = Category.all
  end
end
