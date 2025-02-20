# frozen_string_literal: true

50.times do
  @bulletin = Bulletin.create!(
    title: Faker::Lorem.sentence(word_count: 5),
    description: Faker::Lorem.paragraph(sentence_count: 3),
    category_id: Category.all.sample.id,
    user_id: User.all.sample.id
  )

  @bulletin.image.attach(
    io: Rails.root.join('test/fixtures/files/example_image.jpg').open,
    filename: 'example_image.jpg',
    content_type: 'image/jpeg'
  )
end
