# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bulletins, dependent: :restrict_with_error
  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name id]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['bulletins']
  end
end
