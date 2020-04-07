class Picture < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  validate :image_size

  private

  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "5MBを超える写真はアップロードできません")
    end
  end

end
