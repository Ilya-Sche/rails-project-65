# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin)
    @category = categories(:one)
    sign_in @user
  end

  test 'should get index' do
    get admin_categories_path
    assert_response :success
    assert_select 'h1', 'Categories'
  end

  test 'should show category' do
    get admin_category_path(@category)
    assert_response :success
  end

  test 'should create category' do
    assert_difference('Category.count', 1) do
      post admin_categories_path, params: { category: { name: 'New Category' } }
    end
    assert_redirected_to admin_categories_path
  end

  test 'should get edit' do
    get edit_admin_category_path(@category)
    assert_response :success
  end

  test 'should update category' do
    patch admin_category_path(@category), params: { category: { name: 'Updated Name' } }
    assert_redirected_to admin_categories_path
  end

  test 'should not update category with invalid data' do
    patch admin_category_path(@category), params: { category: { name: '' } }
    assert_response :unprocessable_entity
  end

  test 'should destroy category' do
    assert_difference('Category.count', -1) do
      delete admin_category_path(@category)
    end
    assert_redirected_to admin_categories_path
  end
end
