require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe "メッセージ登録" do
    context "メッセージ登録できる場合" do
      it "全て入力されていれば登録できる" do
        expect(@message).to be_valid
      end
    end
    context "メッセージ登録できない場合" do
      it "text:空" do
        @message.text = ""
        @message.valid?
        expect(@message.errors.full_messages).to include("Text can't be blank")
      end
      it "user:紐づいていない" do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("User must exist")
      end
      it "question:紐づいていない" do
        @message.question = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Question must exist")
      end
    end
  end
end
