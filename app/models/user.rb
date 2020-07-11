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

  def own?(object)
    id == object.user_id
  end
end
