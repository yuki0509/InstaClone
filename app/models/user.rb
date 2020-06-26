class User < ApplicationRecord
  #sorceryで追加された
  authenticates_with_sorcery!

  validates :password, length: {minimum: 3}, if: ->{new_record? || crypted_password_chabged? }
  #これがないとpassword_confirmation属性が追加されない
  validates :password, confirmation: true, if: ->{new_record? || crypted_password_chabged? } 
  validates :password_confirmation, presence: true, if: ->{new_record? || crypted_password_chabged? }
  validates :email, uniqueness: true
end