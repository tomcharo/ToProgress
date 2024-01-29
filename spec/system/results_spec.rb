require 'rails_helper'

RSpec.describe "成績登録", type: :system do
  before do
    @result = FactoryBot.build(:result)
    # 生徒ユーザー作成
    student = FactoryBot.create(:user)
    # 成績を持つユーザーを生徒ユーザーに変更
    @result.user = student
    # 先生ユーザー作成
    @teacher = FactoryBot.create(:user_teacher)
  end

  context "成績登録できる場合" do
    it "生徒が自身の成績を登録できる" do
      # 生徒ユーザーでログイン
      sign_in(@result.user)
      # 成績一覧ページに遷移
      click_on "成績一覧"
      sleep 0.1
      expect(current_path).to eq(student_results_path(@result.user))
      # 値を入力して送信、Resultモデルカウント確認
      fill_in "result_name", with: @result.name
      select @result.category.name, from: "result_category_id"
      expect{
        find('input[name="commit"]').click
        sleep 0.1
      }.to change{Result.count}.by(1)
      # 適切に表示されていることを確認
      expect(page).to have_selector(".header", text: @result.user.last_name)
      expect(page).to have_selector(".main_right", text: @result.name)
      expect(page).to have_button("保存")
      expect(page).not_to have_button("編集")
    end

    it "先生が生徒の成績を登録できる" do
      # 先生ユーザーでログイン
      sign_in(@teacher)
      # 生徒一覧ページに遷移
      click_on "生徒一覧"
      sleep 0.1
      expect(current_path).to eq(students_path)
      # 生徒の成績一覧ページに遷移
      click_on @result.user.last_name
      sleep 0.1
      expect(current_path).to eq(student_results_path(@result.user))
      # 値を入力して送信、Resultモデルカウント確認
      fill_in "result_name", with: @result.name
      select @result.category.name, from: "result_category_id"
      expect{
        find('input[name="commit"]').click
        sleep 0.1
      }.to change{Result.count}.by(1)
      # 適切に表示されていることを確認
      expect(page).to have_selector(".header", text: @teacher.last_name)
      expect(page).to have_selector(".main_right", text: @result.user.last_name)
      expect(page).to have_selector(".main_right", text: @result.name)
      expect(page).to have_button("保存")
      expect(page).not_to have_button("編集")
    end
  end

  context "成績登録できない場合" do
    it "入力に不備があると成績登録できない" do
      # 生徒ユーザーでログイン
      sign_in(@result.user)
      # 成績一覧ページに遷移
      click_on "成績一覧"
      sleep 0.1
      expect(current_path).to eq(student_results_path(@result.user))
      # 値を入力せず送信、Resultモデルカウント確認
      expect{
        find('input[name="commit"]').click
        sleep 0.1
      }.to change{Result.count}.by(0)
      # 成績一覧ページに戻り、エラーメッセージが表示される
      expect(page).to have_current_path(student_results_path(@result.user))
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Category is invalid")
    end

    it "ログインしていないと成績登録できない" do
      visit root_path
      expect(page).not_to have_content("成績一覧")
      expect(page).not_to have_content("生徒一覧")
    end
  end
end

describe "コメント投稿" do
  before do
    @text = "specコメント"
    @result = FactoryBot.create(:result)
    @teacher = FactoryBot.create(:user_teacher)
  end

  context "コメント投稿できる場合" do
    it "生徒が自身の成績にコメントできる" do
      # 生徒ユーザーでログイン
      sign_in(@result.user)
      # 成績一覧ページに遷移
      click_on "成績一覧"
      sleep 0.1
      expect(current_path).to eq(student_results_path(@result.user))
      # 成績詳細ページに遷移
      click_on @result.name
      sleep 0.1
      expect(current_path).to eq(student_result_path(@result.user, @result))
      # コメントを入力して送信、Commentモデルカウント確認
      fill_in "comment_text", with: @text
      expect{
        find('input[value="投稿"]').click
        sleep 0.1
      }.to change{Comment.count}.by(1)
      # 適切に表示されていることを確認(成績詳細ページ)
      expect(current_path).to eq(student_result_path(@result.user, @result))
      expect(page).to have_selector(".header", text: @result.user.last_name)
      expect(page).to have_selector(".main_right", text: @result.name)
      expect(page).to have_selector(".main_right", text: @text)
      expect(page).to have_selector(".main_right", text: "by #{@result.user.last_name}")
    end
    it "先生が生徒の成績にコメントできる" do
      # 先生ユーザーでログイン
      sign_in(@teacher)
      # 生徒一覧ページに遷移
      click_on "生徒一覧"
      sleep 0.1
      expect(current_path).to eq(students_path)
      # 生徒の成績一覧ページに遷移
      click_on @result.user.last_name
      sleep 0.1
      expect(current_path).to eq(student_results_path(@result.user))
      # 成績詳細ページに遷移
      click_on @result.name
      sleep 0.1
      expect(current_path).to eq(student_result_path(@result.user, @result))
      # コメントを入力して送信、Commentモデルカウント確認
      fill_in "comment_text", with: @text
      expect{
        find('input[value="投稿"]').click
        sleep 0.1
      }.to change{Comment.count}.by(1)
      # 適切に表示されていることを確認(成績詳細ページ)
      expect(current_path).to eq(student_result_path(@result.user, @result))
      expect(page).to have_selector(".header", text: @teacher.last_name)
      expect(page).to have_selector(".main_right", text: @result.user.last_name)
      expect(page).to have_selector(".main_right", text: @result.name)
      expect(page).to have_selector(".main_right", text: @text)
      expect(page).to have_selector(".main_right", text: "by #{@teacher.last_name}")
    end
  end
end
