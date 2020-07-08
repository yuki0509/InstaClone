User.limit(3).each do |user|
  #remote_images_urlsでurlからとってくる。画像が単数投稿なら、remote_image_urlで良い。
  post = user.posts.create(body: Faker::Coffee.blend_name, remote_images_urls: %w[https://cdn.pixabay.com/photo/2020/07/04/06/40/clouds-5368435_1280.jpg])
  puts "post#{post.id} has created!"
end