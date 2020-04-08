class Picture < ApplicationRecord
  acts_as_votable
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  validates :title, presence: true
  validate  :image_size



  private
    # アップロードされた画像のサイズをバリデーションする
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "should be less than 5MB")
      end
    end

end
