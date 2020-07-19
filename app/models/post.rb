# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :string(255)      not null
#  images     :json             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  validates :body, presence: true, length: { maximum: 1000 }
  validates :images, presence: true
  # imagesカラムにアップローダークラスをマウントする。carrierwaveの実装にはこの作業が必要。
  mount_uploaders :images, ImageUploader
  belongs_to :user
  # 一つの投稿は複数のコメントを持つ
  has_many :comments, dependent: :destroy
  #一つの投稿は複数のいいねを持っている
  has_many :likes, dependent: :destroy
  # 投稿にいいねしているユーザーを取得できるメソッド。likesテーブルを経由して、usersテーブルを参照する。
  has_many :like_users, through: :likes, source: :user
end
