class UserMailer < ApplicationMailer
  default from: "instaclone@example.com"
  def like_post
    @user_from = params[:user_from]
    @user_to = params[:user_to]
    @post = params[:post]
    mail(to: @user_to.email, subject: "#{@user_from.name}があなたの投稿にいいねしました")
  end
  

end