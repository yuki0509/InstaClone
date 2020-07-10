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
end
