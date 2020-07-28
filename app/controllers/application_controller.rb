class ApplicationController < ActionController::Base
  # 各アクションの前に@search_formを作っておく。
  before_action :set_search_posts_form
  # flashオブジェクトで利用できるキーを追加する
  add_flash_types :success, :info, :warning, :danger

  # sorceryで用意されているメソッド。ログインしていない場合のリダイレクト先。定義しない場合はroot_pathに飛ぶ。
  def not_authenticated
    redirect_to login_path, warning: 'ログインしてください'
  end

  private
  # 検索フォームはナビゲーションバーに共通して、設置してあるため、ApplicationControllerにメソッドをかく。　
  def set_search_posts_form
    @search_form = SearchPostsForm.new(search_post_params)
  end
  
  def search_post_params
    # fetchメソッド。params[:q]の値がないなら、{}を取ってくる。
    params.fetch(:q, {}).permit(:body)
  end
  
end
