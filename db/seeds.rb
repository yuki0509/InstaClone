# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
3.times do 
  username = Faker::Name.name
  email = Faker::Internet.unique.email
  password = 'password'
  User.create(
    username: username,
    email: email,
    password: password,
    password_confirmation: password
  )
end

3.times do |n|
  body = "テスト#{n}"
  user_id = User.first.id
  Post.create(
    body: body,
    user_id: user_id
  )
end