FactoryBot.define do
  factory :comment do
    text {"specコメント"}
    association :user
    association :result
  end
end
