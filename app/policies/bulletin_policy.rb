# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  attr_reader :user, :bulletin

  def initialize(user, bulletin)
    super
    @user = user
    @bulletin = bulletin
  end

  def show?
    return true if bulletin.user_id == user.id

    buletin.state == 'published'
  end

  delegate :admin?, to: :user

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
    bulletin.user == user
  end

  def reject?
    user.admin?
  end

  def publish?
    user.admin?
  end

  def archive?
    user.admin? || bulletin.user == user
  end

  def send_for_moderation?
    bulletin.user == user
  end
end
