FactoryBot.define do
  factory :result do
    name {"spec成績"}
    category_id {1}
    association :user
  end
end
