class SessionsController < ApplicationController
  def new; end

  def create
    user = login(params[:session][:email], params[:session][:password])
    if user
      # sorceryのメソッド。コードで指定したページではなくてURLに保存されたページに移動させる。
      redirect_back_or_to(posts_path, success: 'ログインしました')
    else
      flash.now[:danger] = 'ログイン失敗です。'
      render :new
    end
  end

  def destroy
    # sorceryが提供するメソッド。セッションをリセットする。
    logout
    redirect_to login_path
  end
end
