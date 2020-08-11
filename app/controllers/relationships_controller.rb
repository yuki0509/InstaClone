class RelationshipsController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    # withメソッドで値を渡してテンプレート側でparamsで受け取ることができる。deliver_laterメソッドは、非同期でメールを送ることができ、development/test環境に適していて、production環境にはsidekiqなどを使う必要がある。
    UserMailer.with(user_from: current_user, user_to: @user, followed: @user).follow.deliver_later if current_user.notification_on_follow?
    # 通知設定がtrueの時だけメールを送るようにした
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
  end
end
