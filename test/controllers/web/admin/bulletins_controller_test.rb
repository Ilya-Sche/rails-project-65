# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin)
    @bulletin = bulletins(:one)
    @bulletin_two = bulletins(:two)
    @bulletin.image.attach(io: Rails.root.join('test/fixtures/files/example_image.jpg').open, filename: 'example_image.jpg')
    @bulletin_two.image.attach(io: Rails.root.join('test/fixtures/files/example_image.jpg').open, filename: 'example_image.jpg')
    sign_in @user
  end

  test 'should get admin' do
    get admin_bulletins_path
    assert_response :success
  end

  test 'should get moderation' do
    get moderation_admin_bulletins_path
    assert_response :success
  end

  test 'should get index' do
    get admin_bulletins_path
    assert_response :success
  end

  test 'should show bulletin' do
    get admin_bulletin_path(@bulletin)
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_bulletin_path(@bulletin)
    assert_response :success
  end

  test 'should update bulletin' do
    patch admin_bulletin_path(@bulletin), params: { bulletin: { title: 'Updated title' } }
    assert_redirected_to admin_bulletins_path
  end

  test 'should not update bulletin with invalid data' do
    patch admin_bulletin_path(@bulletin), params: { bulletin: { title: '' } }
    assert_response :unprocessable_entity
  end

  test 'should destroy bulletin' do
    assert_difference('Bulletin.count', -1) do
      delete admin_bulletin_path(@bulletin)
    end
    assert_redirected_to admin_bulletins_path
  end

  test 'should publish bulletin' do
    patch publish_admin_bulletin_path(@bulletin_two)
    @bulletin_two.reload
    assert_equal 'published', @bulletin_two.state
    assert_redirected_to admin_bulletins_path
  end

  test 'should reject bulletin' do
    patch reject_admin_bulletin_path(@bulletin_two)
    @bulletin_two.reload
    assert_equal 'rejected', @bulletin_two.state
    assert_redirected_to admin_bulletins_path
  end

  test 'should archive bulletin' do
    patch archive_admin_bulletin_path(@bulletin)
    @bulletin.reload
    assert_equal 'archived', @bulletin.state
    assert_redirected_to admin_bulletins_path
  end
end
