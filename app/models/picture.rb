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

  has_many :notifications, dependent: :destroy

  def create_notification_favorite!(current_user)
    notification = current_user.active_notifications.new(
      picture_id:self.id,
      visited_id:self.user.id,
      action:"favorite"
    )
    notification.save if notification.valid?
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_comment!(current_user)
    notification = current_user.active_notifications.new(
      picture_id:self.id,
     # comment_id: comment_id,
      visited_id:self.user.id,
      action: "comment"
    )
    notification.save if notification.valid?
  end
  
  private
    # アップロードされた画像のサイズをバリデーションする
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "should be less than 5MB")
      end
    end

end
