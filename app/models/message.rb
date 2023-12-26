class Message < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_one_attached :image

  validates :text, presence: true
end
