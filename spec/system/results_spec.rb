require 'rails_helper'

RSpec.describe "成績登録", type: :system do
  before do
    @result = FactoryBot.build(:result)
    # 生徒ユーザー作成
    student = FactoryBot.create(:user_student)
    # 成績を持つユーザーを生徒ユーザーに変更
    @result.user = student    
  end

  context "成績登録できる場合" do
    it "生徒が自身の成績を登録できる" do
      # 生徒ユーザーでログイン
      sign_in(@result.user)
      # 成績一覧ページに遷移
      click_on "成績一覧"
      sleep 0.1
      expect(current_path).to eq(student_results_path(@result.user))
      # 値を入力、送信
      fill_in "result_name", with: @result.name
      select @result.category.name, from: "result_category_id"
      expect{
        find('input[name="commit"]').click
        sleep 0.1
      }.to change{Result.count}.by(1)
      # 適切に表示されていることを確認
      expect(page).to have_selector(".main_right", text: @result.name)
      expect(page).to have_button("保存")
      expect(page).not_to have_button("編集")
    end
  end
end
