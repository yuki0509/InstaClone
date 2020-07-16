class CommentsController < ApplicationController
  #sorceryで付与されたメソッド。
  before_action :require_login, only: %i[create edit update destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save
    #create.js.slimをクライアントサイドに返す。
  end
  
  def edit
    @comment = current_user.comments.find(params[:id])
    #edit.js.slimをクライアントサイドに返す。
  end
  
  def update
    @comment = current_user.comments.find(params[:id])
    @comment.update(comment_update_params)
    #update.js.slimをクライアントサイドに返す。
  end
  
  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    #destroy.js.slimをクライアントサイドに返す。
  end
  
  private

  def comment_params
    #mergeメソッドはハッシュ同士を結合させるメソッド。フォームではpost_idの値を送信することができないため、後からmergeメソッドでpost_idの値をくっつける。
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
  
  #commentの値しか変更点がないため、comment_paramsとは別にメソッドを設定。
  def comment_update_params
    params.require(:comment).permit(:body)
  end
  
end
