class PostsController < ApplicationController
  before_action :require_login 
  before_action :set_post, only: %i[show edit update destroy]
  
  #current_userはsorceryで与えられたメソッド
  def index
    @posts = current_user.posts.all.order(created_at: :desc)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    
    
    if @post.save
      redirect_to posts_path, success: '投稿しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, success: '投稿を更新しました'
    else
      flash.now[:danger] = "更新失敗しました"
      render :edit
    end
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path, success: '投稿を削除しました'
  end

  private
  def post_params
    #images:[]とすることで複数ファイルが保存できる
    params.require(:post).permit(:body, images:[])
  end
  
  def set_post
    @post = current_user.posts.find(params[:id])
  end
  
end
