class LikesController < ApplicationController
  def create
    # urlのクエリからパラメーターとして受け取る。
    @post = Post.find(params[:post_id])
    current_user.like(@post)
  end
  
  def destroy
    # いいねした投稿を取得。
    @post = Like.find(params[:id]).post
    current_user.unlike(@post)
  end
  
end
