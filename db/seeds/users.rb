# frozen_string_literal: true

User.create!(
  name: 'Администратор',
  email: 'admin@example.com',
  admin: true
)

10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email
  )
end
