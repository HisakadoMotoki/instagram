class User < ApplicationRecord
  has_many :pictures
  has_many :favorites

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
