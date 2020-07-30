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
  # 新規登録された順に引数の数だけ取得する。
  scope :recent, ->(count) { order(created_at: :desc).limit(count) }

  # sorceryで追加された
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  # これがないとpassword_confirmation属性が追加されない
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true

  # userが削除されたら、関連するpostも削除される
  has_many :posts, dependent: :destroy
  # 一人のユーザーは複数のコメントを持つ
  has_many :comments, dependent: :destroy
  # 一人のユーザーは複数の投稿にいいねができる。
  has_many :likes, dependent: :destroy
  # ユーザーがいいねしている投稿を取得できるメソッド。中間テーブルのlikesテーブルを経由してpostsテーブルを参照する。user_idと対になってるpost_idの投稿を取ってくる。
  has_many :like_posts, through: :likes, source: :post

  # 仮想のactive_relationshipモデルを作っている(中身はrelationshipモデル)。follower_idを外部キーに指定して、relationshipテーブルをfollowerテーブルの視点から見る。
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  # 仮想のpassive_relationshipモデルを作っている(中身はrelationshipモデル)。followed_idを外部キーに指定して、relationshipテーブルをfollowedテーブルの視点から見る。
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  # ユーザーがフォローしている人の値を取得する。
  has_many :following, through: :active_relationships, source: :followed
  # ユーザーのフォロワーの値を取得する。
  has_many :followers, through: :passive_relationships, source: :follower

  def own?(object)
    id == object.user_id
  end

  def like(post)
    like_posts << post
  end

  def unlike(post)
    # destroyメソッドは引数と一致したものを削除。
    like_posts.destroy(post)
  end

  # いいねしているかの確認
  def like?(post)
    # 配列形式で取得した投稿の中にオブジェクトが含んでいるのかを探す。含んでいたらtrueを返す。
    like_posts.include?(post)
  end

  # フォローするメソッド。
  def follow(other_user)
    following << other_user
  end

  # フォローを外すメソッド。
  def unfollow(other_user)
    following.destroy(other_user)
  end

  # フォローしているかどうかを確かめるメソッド。
  def followings?(other_user)
    following.include?(other_user)
  end

  # フィード表示するメソッド。フォローしているユーザーと自分の投稿だけ見れるようにする・
  def feed
    # following_idsでfollowingで取得できるユーザーのidのみを取得する。
    Post.where(user_id: following_ids << id)
  end
end
