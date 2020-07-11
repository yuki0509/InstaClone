puts 'Start inserting seed "posts" ...'
User.limit(15).each do |user|
  #%w[]で配列を返す。
  post = user.posts.create(body: Faker::Food.description, remote_images_urls: %w[https://pakutaso.cdn.rabify.me/shared/img/thumb/nekocyan458A3307.jpg.webp?d=500])
  puts "post#{post.id} has created!"
end