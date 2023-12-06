class Result < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  belongs_to :user
  has_many :subjects
  has_many :comments

  validates :name, presence: true
  validates :category_id, numericality: { in: 1..3, message: "is invalid" }
end
