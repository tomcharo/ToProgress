FactoryBot.define do
  factory :message do
    text {"testtext"}
    association :user
    association :question
  end
end
