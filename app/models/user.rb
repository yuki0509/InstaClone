# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  email            :string(255)      not null
#  name             :string(255)      not null
#  salt             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  # sorceryで追加された
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || crypted_password_chabged? }
  # これがないとpassword_confirmation属性が追加されない
  validates :password, confirmation: true, if: -> { new_record? || crypted_password_chabged? }
  validates :password_confirmation, presence: true, if: -> { new_record? || crypted_password_chabged? }
  validates :email, presence: true, uniqueness: true

  # userが削除されたら、関連するpostも削除される
  has_many :posts, dependent: :destroy
  # 一人のユーザーは複数のコメントを持つ
  has_many :comments, dependent: :destroy
  # 一人のユーザーは複数の投稿にいいねができる。
  has_many :likes, dependent: :destroy
  # ユーザーがいいねしている投稿を取得できるメソッド。中間テーブルのlikesテーブルを経由してpostsテーブルを参照する。user_idと対になってるpost_idの投稿を取ってくる。
  has_many :like_posts, through: :likes, source: :post

  def own?(object)
    id == object.user_id
  end

  def like(post)
    
    self.like_posts << post
  end

  def unlike(post)
    # destroyメソッドは引数と一致したものを削除。
    self.like_posts.destroy(post)
  end

  # いいねしているかの確認
  def like?(post)
    # 配列形式で取得した投稿の中にオブジェクトが含んでいるのかを探す。含んでいたらtrueを返す。
    self.like_posts.include?(post)
  end
  
end
