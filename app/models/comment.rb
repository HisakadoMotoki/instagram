# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :picture
  validates :content, presence: true, length: { maximum: 100 }
end
