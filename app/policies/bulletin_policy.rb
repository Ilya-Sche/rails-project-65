# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  attr_reader :user, :bulletin

  def initialize(user, bulletin)
    super
    @user = user
    @bulletin = bulletin
  end

  def show?
    true
  end

  def edit?
    bulletin.user == user
  end

  def create?
    user.present?
  end

  def update?
    user.admin? || bulletin.user == user
  end

  def destroy?
    user.admin? || bulletin.user == user
  end
end
