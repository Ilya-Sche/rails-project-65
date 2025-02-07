# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :category
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, size: { less_than: 5.megabytes }, content_type: ['image/png', 'image/jpeg'], presence: true

  has_one_attached :image

  aasm column: :state do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :send_for_moderation do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title description state]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['category']
  end
end
