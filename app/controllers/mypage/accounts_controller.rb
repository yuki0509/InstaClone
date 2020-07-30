class Mypage::AccountsController < ApplicationController
  def edit
    @user_account = current_user
  end

  def update
    @user_account = current_user
    if @user_account.update(user_account_params)
      redirect_to edit_mypage_account_path, success: 'プロフィールを更新しました'
    else
      render :edit
    end
  end

  private
  def user_account_params
    params.require(:user).permit(:name)
  end
  
end
