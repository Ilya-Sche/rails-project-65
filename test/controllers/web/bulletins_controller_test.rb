# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @category = categories(:one)
    @bulletin = bulletins(:one)
    sign_in @user
  end

  test 'should get index' do
    get bulletins_url
    assert_response :success
  end

  test 'should show bulletin' do
    get bulletin_url(@bulletin)
    assert_response :success
    assert_select 'h1', @bulletin.title
  end

  test 'should get new' do
    get new_bulletin_url
    assert_response :success
    assert_select 'form'
  end

  test 'should create bulletin with valid params' do
    assert_difference('Bulletin.count', 1) do
      post bulletins_url, params: { bulletin: { title: 'New Bulletin', description: 'Description', category_id: @category.id, state: 'draft' } }
    end
    assert_redirected_to bulletin_url(Bulletin.last)
  end

  test 'should not create bulletin with invalid params' do
    assert_no_difference('Bulletin.count') do
      post bulletins_url, params: { bulletin: { title: '', description: 'Description', category_id: @category.id, state: 'draft' } }
    end
    assert_response :unprocessable_entity
  end

  test 'should update bulletin with valid params' do
    patch bulletin_url(@bulletin), params: { bulletin: { title: 'Updated Title' } }
    @bulletin.reload
    assert_equal 'Updated Title', @bulletin.title
    assert_redirected_to bulletin_url(@bulletin)
  end

  test 'should not update bulletin with invalid params' do
    patch bulletin_url(@bulletin), params: { bulletin: { title: '' } }
    assert_response :unprocessable_entity
  end

  test 'should destroy bulletin' do
    assert_difference('Bulletin.count', -1) do
      delete bulletin_url(@bulletin)
    end
    assert_redirected_to bulletins_url
  end

  test 'should send bulletin for moderation' do
    post send_for_moderation_bulletin_url(@bulletin)
    @bulletin.reload
    assert_equal 'under_moderation', @bulletin.state
  end

  test 'should archive bulletin' do
    post archive_bulletin_url(@bulletin)
    @bulletin.reload
    assert_equal 'archived', @bulletin.state
  end
end
