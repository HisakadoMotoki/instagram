# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :image
  mount_uploader :image, ImageUploader
  has_many :pictures, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_pictures, through: :favorites, source: :picture

  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: :following_id
  has_many :followings, through: :active_relationships,
                        source: :follower

  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  has_many :active_notifications, class_name: 'Notification',
                                  foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification',
                                   foreign_key: 'visited_id', dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def create_notification_follow!(current_user)
    notification = current_user.active_notifications.new(
      visited_id: id,
      action: 'follow'
    )
    notification.save if notification.valid?
  end

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      email: auth.info.email,
      name: auth.info.name,
      password: Devise.friendly_token[0, 20],
      image: auth.info.image
    )

    user
  end
end
