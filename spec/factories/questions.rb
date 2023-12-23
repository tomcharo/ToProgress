FactoryBot.define do
  factory :question do
    title {"testtitle"}
    closed {false}
    association :user
  end
end
