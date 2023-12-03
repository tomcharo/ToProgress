class Subject < ApplicationRecord
  belongs_to :result

  validates :name, presence: true
  validates :max_score, numericality: true
  validates :score, :average_score, :rank, :rank_range, numericality: {allow_nil: true}
end
