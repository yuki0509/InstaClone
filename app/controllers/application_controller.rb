class ApplicationController < ActionController::Base
  # flashオブジェクトで利用できるキーを追加する
  add_flash_types :success, :info, :warning, :danger
end
