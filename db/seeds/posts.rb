puts 'Start inserting seed "posts" ...'
User.limit(3).each do |user|
  #%wは配列を返すはずだから、%w()でもいいと思ったが、%w()ではデータを挿入できなかった。教えて欲しいです！
  post = user.posts.create(body: Faker::Food.description, remote_images_urls: %w[https://pakutaso.cdn.rabify.me/shared/img/thumb/nekocyan458A3307.jpg.webp?d=500])
  puts "post#{post.id} has created!"
end