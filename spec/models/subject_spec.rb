require 'rails_helper'

RSpec.describe Subject, type: :model do
  before do
    @subject = FactoryBot.build(:subject)
  end

  describe "科目登録" do
    context "科目登録できる場合" do
      it "全て入力されていれば登録できる" do
        expect(@subject).to be_valid
      end
      it "score:空" do
        @subject.score = nil
        expect(@subject).to be_valid
      end
      it "average_score:空" do
        @subject.average_score = nil
        expect(@subject).to be_valid
      end
      it "rank:空" do
        @subject.rank = nil
        expect(@subject).to be_valid
      end
      it "rank_range:空" do
        @subject.rank_range = nil
        expect(@subject).to be_valid
      end
    end
    context "科目登録できない場合" do
      it "name:空" do
        @subject.name = ""
        @subject.valid?
        expect(@subject.errors.full_messages).to include("Name can't be blank")
      end
      it "score:数値でない" do
        @subject.score = "a"
        @subject.valid?
        expect(@subject.errors.full_messages).to include("Score is not a number")
      end
      it "max_score:空" do
        @subject.max_score = nil
        @subject.valid?
        expect(@subject.errors.full_messages).to include("Max score is not a number")
      end
      it "max_score:数値でない" do
        @subject.max_score = "a"
        @subject.valid?
        expect(@subject.errors.full_messages).to include("Max score is not a number")
      end
      it "average_score:数値でない" do
        @subject.average_score = "a"
        @subject.valid?
        expect(@subject.errors.full_messages).to include("Average score is not a number")
      end
      it "rank:数値でない" do
        @subject.rank = "a"
        @subject.valid?
        expect(@subject.errors.full_messages).to include("Rank is not a number")
      end
      it "rank_range:数値でない" do
        @subject.rank_range = "a"
        @subject.valid?
        expect(@subject.errors.full_messages).to include("Rank range is not a number")
      end
      it "result:紐づいていない" do
        @subject.result = nil
        @subject.valid?
        expect(@subject.errors.full_messages).to include("Result must exist")
      end
    end
  end
end
