class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  # リダイレクトのパスをroot以外にする場合は自分で書き換える。
  def not_authenticated
    redirect_to login_path, warning: 'ログインしてください'
  end
end
