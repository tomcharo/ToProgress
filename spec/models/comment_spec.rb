require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe "コメント登録" do
    context "コメント登録できる場合" do
      it "全て入力されていれば登録できる" do
        expect(@comment).to be_valid
      end
    end
    context "コメント登録できない場合" do
      it "text:空" do
        @comment.text = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
      it "user:紐づいていない" do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("User must exist")
      end
      it "result:紐づいていない" do
        @comment.result = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Result must exist")
      end
    end
  end
end
