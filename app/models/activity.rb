# == Schema Information
#
# Table name: activities
#
#  id           :bigint           not null, primary key
#  action_type  :integer          not null
#  read         :boolean          default("unread"), not null
#  subject_type :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  subject_id   :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_activities_on_subject_type_and_subject_id  (subject_type,subject_id)
#  index_activities_on_user_id                      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Activity < ApplicationRecord
  # モデルでpost_pathなどのパスを使用したい場合は、これを書く必要がある。
  include Rails.application.routes.url_helpers

  # ポリモーフィック関連づけを行っている。object.subjectで対応するオブジェクトをクラスを気にせずに取得できる。
  belongs_to :subject, polymorphic: true
  belongs_to :user

  scope :recent, ->(count) { order(created_at: :desc).limit(count) }

  # enumは、一つのカラムに指定した複数個の定数を保存できるようにする。データベースにはハッシュのバリューが保存され、action_typeカラムにはハッシュのキー名を保存する。
  enum action_type: { commented_to_own_post: 0, liked_to_own_post: 1, followed_me: 2 }

  # enumでreadカラムの値をunreadとreadに限定する。
  enum read: { unread: false, read: true }

  def redirect_path
    case action_type.to_sym
    # action_typeごとにクライアントに返すページを分ける
    when :commented_to_own_post
      # anchorオプションでanchorリンクが生成される。urlの末尾に#comment-idが追加され、id="comment-id"がついているタグに飛ぶ。
      post_path(self.subject.post, anchor: "comment-#{subject.id}")
    when :liked_to_own_post
      post_path(self.subject.post)
    when :followed_me
      user_path(self.subject.follower)
    end
  end
  
end
