class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # メールアドレスやパスワードを使い自動でログインする
      auto_login(@user)
      redirect_to login_path, success: 'ユーザーが作成されました'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
