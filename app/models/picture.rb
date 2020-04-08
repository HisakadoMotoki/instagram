class Picture < ApplicationRecord
  belongs_to :user
  has_many :favorites
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  validates :title, presence: true
  validate  :image_size

def favorited_by?(user)
  favorites.where(user_id: user.id).exists?
end


  private
    # アップロードされた画像のサイズをバリデーションする
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "should be less than 5MB")
      end
    end

end
