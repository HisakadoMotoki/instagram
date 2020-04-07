class Picture < ApplicationRecord
  acts_as_votable
  belongs_to :user
  mount_uploader :image, ImageUploader
  validate :image_size

end
