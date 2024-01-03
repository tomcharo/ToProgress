FactoryBot.define do
  factory :user do
    email {"test@spectest"}
    password {"111111"}
    password_confirmation {password}
    last_name {"山田"}
    first_name {"トム"}
    grade_id {1}

    factory :user_student do
      grade_id {2}
    end
  end
end