require 'rails_helper'

RSpec.describe Result, type: :model do
  before do
    @result = FactoryBot.build(:result)
  end

  describe "成績登録" do
    context "成績登録できる場合" do
      it "全て入力されていれば登録できる" do
        expect(@result).to be_valid
      end
    end
    context "成績登録できない場合" do
      it "name:空" do
        @result.name = ""
        @result.valid?
        expect(@result.errors.full_messages).to include("Name can't be blank")
      end
      it "category_id:0" do
        @result.category_id = 0
        @result.valid?
        expect(@result.errors.full_messages).to include("Category is invalid")
      end
      it "user:紐づいていない" do
        @result.user = nil
        @result.valid?
        expect(@result.errors.full_messages).to include("User must exist")
      end
    end
  end
end
