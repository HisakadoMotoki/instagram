class Picture < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :commenters, through: :commments, source: :user
  has_many_attached :image
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
