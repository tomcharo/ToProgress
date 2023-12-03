FactoryBot.define do
  factory :user do
    email {"test@spectest"}
    password {"111111"}
    password_confirmation {password}
    last_name {"山田"}
    first_name {"トム"}
    grade_id {1}
  end
end