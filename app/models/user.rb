class User < ApplicationRecord
  has_many :pictures
  has_many :favorites
  has_many :favorite_pictures, through: :favorites, source: :picture

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
