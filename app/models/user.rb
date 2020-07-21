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

  has_many :relationships
  # 中間テーブルであるrelationshipテーブルを通過して、仮想で作成したfollowテーブル（userテーブル）を参照する。フォローしてる人たちを取得する。
  has_many :follwings, through: :relationships, source: :follow
  # 仮想でreverse_of_relationshipテーブル（本当はrelationshipテーブル）を作っている。フォローされる側からuserテーブルを見るようなイメージ。
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  # 仮想で作ったreverse_of_relationshipsテーブルを経由して、userテーブルを参照する。フォロワーを取得するメソッド。
  has_many :followers, through: :reverse_of_relationships, source: :user


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

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def followings?(other_user)
    self.followings.include?(other_user)
  end
  
end
