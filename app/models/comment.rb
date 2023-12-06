class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :result

  validates :text, presence: true
end
