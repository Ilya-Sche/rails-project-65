# frozen_string_literal: true

10.times do
  Category.create!(
    name: Faker::Commerce.department
  )
end
