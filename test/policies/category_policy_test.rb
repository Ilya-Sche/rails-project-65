# frozen_string_literal: true

require 'test_helper'

class CategoryPolicyTest < ActiveSupport::TestCase
  def setup
    @admin = users(:admin)
    @user = users(:one)
    @category = categories(:one)
  end

  def test_create
    assert CategoryPolicy.new(@admin, @category).create?

    assert_not CategoryPolicy.new(@user, @category).create?
  end

  def test_edit
    assert CategoryPolicy.new(@admin, @category).edit?

    assert_not CategoryPolicy.new(@user, @category).edit?
  end

  def test_update
    assert CategoryPolicy.new(@admin, @category).update?

    assert_not CategoryPolicy.new(@user, @category).update?
  end

  def test_destroy
    assert CategoryPolicy.new(@admin, @category).destroy?

    assert_not CategoryPolicy.new(@user, @category).destroy?
  end
end
