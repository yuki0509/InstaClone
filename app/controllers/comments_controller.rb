class CommentsController < ApplicationController
  #sorceryで付与されたメソッド。
  before_action :require_login, only: %i[create edit update destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save!
    redirect_to post_path(@comment.post)
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to posts_path
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
    redirect_to posts_path
  end
  
  private

  def comment_params
    #mergeメソッドはハッシュ同士を結合させるメソッド。
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
  
end
