FactoryBot.define do
  factory :message do
    text {"testtext"}
    association :user
    association :question

    after(:build) do |message|
      message.image.attach(io: File.open("public/images/test_image.png"), filename: "test_image.png")
    end
  end
end
