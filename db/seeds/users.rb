3.times do 
  username = Faker::Name.unique.name
  email = Faker::Internet.unique.email
  password = 'password'
  user = User.create(
    username: username,
    email: email,
    password: password,
    password_confirmation: password
  )
  puts "\"#{user.username}\" has created!"
end