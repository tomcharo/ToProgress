FactoryBot.define do
  factory :comment do
    text {"testcomment"}
    association :user
    association :result
  end
end
