# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p "seeding 20 books"

20.times do |n|
  Book.create! title: Faker::Book.title,
                author: Faker::Book.author,
                image: Faker::Avatar.image
end

p "seeding 10 users"
10.times do |u|
  User.create! email: Faker::Internet.email,
  password: "test_user"
end

p "seeding 100 reviews"
100.times do |r|
  Review.create! title: "Best book ever",
                 content_rating: Faker::Number.between(1, 10),
                 comment_rating: Faker::Number.between(1, 10),
                 user_id: Faker::Number.between(1, 10),
                 book_id: Faker::Number.between(1, 20)
end
