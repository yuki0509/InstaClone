class PostsController < ApplicationController
  # sorceryで用意されているメソッド
  before_action :require_login, only: %i[new create edit update destroy]

  def index
    # N+1問題に関係する。ページネーション追加(paramsで現在のページ数を受け取る)
    @posts = if current_user
                current_user.feed.includes(:user).page(params[:page])
              else
                Post.all.includes(:user).page(params[:page])
              end
    @users = User.recent.limit(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, success: '投稿を作成しました'
    else
      flash.now[:danger] = '投稿作成を失敗しました'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    # 詳細画面にコメントを表示するためにインスタンス変数追加。
    @comments = @post.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, success: '投稿を更新しました'
    else
      flash.now[:danger] = '投稿更新を失敗しました'
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    # 削除失敗したら、例外処理が起こる
    @post.destroy!
    redirect_to posts_path, success: '投稿を削除しました'
  end

  private

  def post_params
    # imagesは複数画像を配列形式で受け取るためこのように書き必要がある
    params.require(:post).permit(:body, images: [])
  end
end
