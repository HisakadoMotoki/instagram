class User < ApplicationRecord
  has_many :pictures

  extend Enumerize
  enumerize :sex, in: {unkown: -1, male: 0, female: 1, other: 99}, scope: :having_status

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
