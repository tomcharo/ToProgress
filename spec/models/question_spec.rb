require 'rails_helper'

RSpec.describe Question, type: :model do
  before do
    @question = FactoryBot.build(:question)
  end

  describe "質問作成" do
    context "質問作成できる場合" do
      it "全て入力されていれば登録できる" do
        expect(@question).to be_valid
      end
    end
    context "質問作成できない場合" do
      it "title:空" do
        @question.title = ""
        @question.valid?
        expect(@question.errors.full_messages).to include("Title can't be blank")
      end
      it "closed:nil" do
        @question.closed = nil
        @question.valid?
        expect(@question.errors.full_messages).to include("Closed is not included in the list")
      end
      it "user:紐づいていない" do
        @question.user = nil
        @question.valid?
        expect(@question.errors.full_messages).to include("User must exist")
      end
    end
  end
end
