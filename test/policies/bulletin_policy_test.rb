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

  def test_create
    assert BulletinPolicy.new(@admin, Bulletin).create?

    assert BulletinPolicy.new(@user, Bulletin).create?
  end

  def test_edit
    assert_not BulletinPolicy.new(@admin, @bulletin).edit?

    assert BulletinPolicy.new(@user, @bulletin).edit?
    assert_not BulletinPolicy.new(@user, @other_bulletin).edit?
  end

  def test_update
    assert BulletinPolicy.new(@admin, @bulletin).update?
    assert BulletinPolicy.new(@admin, @other_bulletin).update?

    assert BulletinPolicy.new(@user, @bulletin).update?
    assert_not BulletinPolicy.new(@user, @other_bulletin).update?
  end

  def test_destroy
    assert BulletinPolicy.new(@admin, @bulletin).destroy?
    assert BulletinPolicy.new(@admin, @other_bulletin).destroy?

    assert BulletinPolicy.new(@user, @bulletin).destroy?
    assert_not BulletinPolicy.new(@user, @other_bulletin).destroy?
  end
end
