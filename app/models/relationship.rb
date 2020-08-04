# == Schema Information
#
# Table name: relationships
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer          not null
#  follower_id :integer          not null
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
class Relationship < ApplicationRecord
  # 仮想のfollowrモデルを作っている。実際はuserモデルであるためclass_nameオプションをつける。
  belongs_to :follower, class_name: 'User'
  # 仮想のfollowedモデルを作っている。実際はuserモデルであるためclass_nameオプションをつける。
  belongs_to :followed, class_name: 'User'
  # フォロー機能には一つの通知しか作成されないから、has_oneを使用。as: :subjectでポリモフィック関連づけを行っている。
  has_one :activity, as: :subject, dependent: :destroy
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  # follower_idとfollowed_idをセットでユニーク制約をかける。同じユーザーへのフォローを複数回できることを禁止する。
  validates :follower_id, uniqueness: { scope: :followed_id }

  after_create_commit :create_activities

  private
  def create_activities
    # self.followedでフォローされたユーザーを取得できる。
    Activity.create(subject: self, user: followed, action_type: :followed_me)
  end
  
end
