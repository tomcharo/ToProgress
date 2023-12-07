class Question < ApplicationRecord
  belongs_to :user
  has_many :messages

  validates :title, presence: true
  validates :closed, inclusion: [true, false]
end
