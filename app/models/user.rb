class User < ApplicationRecord
  has_many :pictures

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
