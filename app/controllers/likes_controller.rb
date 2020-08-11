class LikesController < ApplicationController
  def create
    # urlのクエリからパラメーターとして受け取る。
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    # withメソッドで値を渡してテンプレート側でparamsで受け取ることができる。deliver_laterメソッドは、非同期でメールを送ることができ、development/test環境に適していて、production環境にはsidekiqなどを使う必要がある。
    UserMailer.with(user_from: current_user, user_to: @post.user, post: @post).like_post.deliver_later if current_user.notification_on_like?
  end

  def destroy
    # いいねした投稿を取得。
    @post = Like.find(params[:id]).post
    current_user.unlike(@post)
  end
end
