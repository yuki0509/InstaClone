class Post < ApplicationRecord
  validates :body, presence: true
  validates :images, presence: true
  #imagesカラムにImageUploaderをマウントさせる。carrierwaveの実装には欠かせない作業。
  mount_uploaders :images, ImageUploader

  belongs_to :user
end
