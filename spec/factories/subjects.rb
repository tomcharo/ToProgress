FactoryBot.define do
  factory :subject do
    name {"spec科目"}
    score {50}
    max_score {100}
    average_score {40}
    rank {10}
    rank_range {30}
    association :result
  end
end
