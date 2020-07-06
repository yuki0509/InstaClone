class Post < ApplicationRecord
  validates :body, presence: true
  mount_uploaders :images, ImageUploader

  belongs_to :user
end
