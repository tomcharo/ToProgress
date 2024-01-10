FactoryBot.define do
  factory :question do
    title {"spec質問"}
    closed {false}
    association :user
  end
end
