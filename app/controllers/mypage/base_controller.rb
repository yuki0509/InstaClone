class Mypage::BaseController < ApplicationController
  before_action :require_login
  # mypageをレイアウト指定する
  layout 'mypage'
end
