class SessionsController < ApplicationController
  skip_before_action :require_login
  def new
  end

  def create
    user = login(params[:session][:email], params[:session][:password])
    if user
      # sorceryのメソッド。コードで指定したページではなくてURLに保存されたページに移動させる。
      redirect_back_or_to(users_path, success: 'ログインしました')
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
