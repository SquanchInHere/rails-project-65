# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

users = []
STATES = Bulletin.aasm.states.map(&:name)

5.times do
  users << User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email
  )
end

3.times do
  category = Category.find_or_create_by(name: Faker::ProgrammingLanguage.name)
  bulletin_image = ['first.jpg', 'second.jpg', 'third.jpg'].map do |file_path|
    Rails.root.join("test/fixtures/files/#{file_path}")
  end

  20.times do
    bulletin = users.sample.bulletins.build(
      description: Faker::Lorem.paragraph,
      title: Faker::Lorem.sentence(word_count: 3),
      category:,
      state: STATES.sample
    )
    bulletin.image.attach(io: File.open(bulletin_image.sample), filename: 'filename.jpg')
    bulletin.save
    sleep 1
  end
end
