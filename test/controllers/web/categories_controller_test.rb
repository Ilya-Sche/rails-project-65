# frozen_string_literal: true

require 'test_helper'

class Web::CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = categories(:one)
  end

  test 'should get index' do
    get categories_path
    assert_response :success
  end

  test 'should show category' do
    get category_path(@category)
    assert_response :success
  end
end
