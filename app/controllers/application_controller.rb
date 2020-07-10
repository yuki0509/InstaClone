class ApplicationController < ActionController::Base
  # flashオブジェクトで利用できるキーを追加する
  add_flash_types :success, :info, :warning, :danger

  #sorceryで用意されているメソッド。ログインしていない場合のリダイレクト先。定義しない場合はroot_pathに飛ぶ。
  def not_authenticated
    redirect_to login_path, warning: 'ログインしてください'
  end
  
end
