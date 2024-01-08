FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password {"111111"}
    password_confirmation {password}
    last_name {"高橋"}
    first_name {"葵"}
    grade_id {2}

    factory :user_teacher do
      last_name {"山田"}
      first_name {"トム"}
      grade_id {1}
    end
  end
end