class ApplicationController < ActionController::Base
  # sorceryで用意されているメソッド
  before_action :require_login
  #flashオブジェクトで利用できるキーを追加する
  add_flash_types :success, :info, :warning, :danger
  # 外部には公開されないが、同クラスやサブクラスでのみ呼び出せるメソッドを設定
  protected

  def not_authenticated
    redirect_to root_path
  end
end
