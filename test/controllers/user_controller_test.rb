# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @other_user = users(:two)
  end

  test 'should get show for logged-in user' do
    sign_in @user
    get profile_url(@user)
    assert_response :success
  end

  test 'should redirect show for non-logged-in user' do
    get profile_url(@user)
    assert_redirected_to root_path
    assert_equal flash[:alert], I18n.t('user.auth')
  end

  test 'should create user' do
    assert_difference 'User.count', 1 do
      post users_url, params: { user: { email: 'newuser@example.com', name: 'New User' } }
    end
    assert_redirected_to root_path
    assert_equal flash[:notice], I18n.t('user.entered')
  end
end
