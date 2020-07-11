puts 'Start inserting seed "users" ...'
15.times do
  user = User.create(
    #ドラゴンボールのキャラクターを入れました！
    name: Faker::JapaneseMedia::DragonBall.character,
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password'
  )
  puts "\"#{user.name}\" has created!"
end