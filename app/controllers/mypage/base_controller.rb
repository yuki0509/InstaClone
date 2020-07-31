# Mypageに諸々の機能を追加するので、BaseControllerを作成して拡張性を高くする。
class Mypage::BaseController < ApplicationController
  before_action :require_login
  # mypageをレイアウト指定する
  layout 'mypage'
end
