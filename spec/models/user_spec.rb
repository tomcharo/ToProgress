require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "新規登録できる場合" do
      it "全て入力されていれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context "新規登録できない場合" do
      it "email:空" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "email:重複" do
        user2 = FactoryBot.create(:user)
        @user.email = user2.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
      it "email:@を含まない" do
        @user.email = "emailtest"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "password:空" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "password:6文字より少ない" do
        @user.password = "11111"
        @user.password_confirmation = "11111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "password:password_confirmationと一致しない" do
        @user.password = "111111"
        @user.password_confirmation = "222222"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "last_name:空" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "last_name:全角でない" do
        @user.last_name = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end
      it "first_name:空" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "first_name:全角でない" do
        @user.first_name = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end
      it "grade_id:0" do
        @user.grade_id = 0
        @user.valid?
        expect(@user.errors.full_messages).to include("Grade is invalid")
      end
    end
  end
end
