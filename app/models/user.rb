class User < ApplicationRecord
  has_many :pictures
  has_many :favorites
  has_many :favorite_pictures, through: :favorites, source: :picture

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
