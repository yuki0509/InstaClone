# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_likes_on_post_id              (post_id)
#  index_likes_on_user_id              (user_id)
#  index_likes_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # いいねを一度したら、通知は一つしか作成されないので、has_oneを使用する。as: :subjectでポリモーフィック関連づけを行っている。
  has_one :activity, as: :subject, dependent: :destroy
  # post_idとuser_idの組が１組しかないようにバリデーションをかける
  validates :user_id, uniqueness: { scope: :post_id }
  # データベースにレコードが挿入されるとcreate_activitiesメソッドが呼び出される。
  after_create_commit :create_activities

  private
  def create_activities
    # likeモデルのインスタンスメソッドの中なので、selfはlikeモデルのオブジェクトになる。self.post.userでいいねされた方のユーザーを取得できる。
    Activity.create(subject: self, user: self.post.user, action_type: :liked_to_own_post)
  end
  
end
