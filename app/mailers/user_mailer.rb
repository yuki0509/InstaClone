class UserMailer < ApplicationMailer
  default from: 'instaclone@example.com'

  def like_post
    # withメソッドで渡された値をparamsで受け取ることができる。
    @user_from = params[:user_from]
    @user_to = params[:user_to]
    @post = params[:post]
    # mailはデフォルトでto,from,date,subjectが使われるため、その値を記述する必要がある。
    mail(to: @user_to.email, subject: "#{@user_from.name}があなたの投稿にいいねしました")
  end

  def comment_post
    # withメソッドで渡された値をparamsで受け取ることができる。
    @user_from = params[:user_from]
    @user_to = params[:user_to]
    @post = params[:post]
    # mailはデフォルトでto,from,date,subjectが使われるため、その値を記述する必要がある。
    mail(to: @user_to.email, subject: "#{@user_from.name}があなたの投稿にコメントしました")
  end

  def follow
    # withメソッドで渡された値をparamsで受け取ることができる。
    @user_from = params[:user_from]
    @user_to = params[:user_to]
    @followed = params[:followed]
    # mailはデフォルトでto,from,date,subjectが使われるため、その値を記述する必要がある。
    mail(to: @user_to.email, subject: "#{@user_from.name}があなたをフォローしました")
  end
end
