FactoryBot.define do
  factory :result do
    name {"testname"}
    category_id {1}
    association :user
  end
end
