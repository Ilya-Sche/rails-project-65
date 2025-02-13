# frozen_string_literal: true

require 'test_helper'

class BulletinPolicyTest < ActiveSupport::TestCase
  def setup
    @admin = users(:admin)
    @user = users(:one)
    @other_user = users(:two)
    @bulletin = bulletins(:one)
    @other_bulletin = bulletins(:two)
  end

  def test_edit
    assert BulletinPolicy.new(@user, @bulletin).edit?
    assert_not BulletinPolicy.new(@user, @other_bulletin).edit?
  end

  def test_update
    assert BulletinPolicy.new(@user, @bulletin).update?
    assert_not BulletinPolicy.new(@user, @other_bulletin).update?
  end
end
