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

  test 'should get new' do
    get new_category_path
    assert_response :success
  end

  test 'should create category' do
    assert_difference('Category.count', 1) do
      post categories_path, params: { category: { name: 'New Category' } }
    end
    assert_redirected_to categories_path
  end

  test 'should not create category with invalid data' do
    assert_no_difference('Category.count') do
      post categories_path, params: { category: { name: '' } }
    end
    assert_response :unprocessable_entity
  end

  test 'should get edit' do
    get edit_category_path(@category)
    assert_response :success
  end

  test 'should update category' do
    patch category_path(@category), params: { category: { name: 'Updated Name' } }
    assert_redirected_to category_path(@category)
  end

  test 'should not update category with invalid data' do
    patch category_path(@category), params: { category: { name: '' } }
    assert_response :unprocessable_entity
  end

  test 'should destroy category' do
    assert_difference('Category.count', -1) do
      delete category_path(@category)
    end
    assert_redirected_to categories_path
  end
end
