# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  attr_reader :user, :bulletin

  def initialize(user, bulletin)
    super
    @user = user
    @bulletin = bulletin
  end

  def show?
    return true if user && bulletin.user_id == user.id

    bulletin.published?
  end

  def edit?
    bulletin.user == user
  end

  def update?
    bulletin.user == user
  end

  def destroy?
    bulletin.user == user
  end

  def archive?
    bulletin.user == user
  end

  def send_for_moderation?
    bulletin.user == user
  end
end
