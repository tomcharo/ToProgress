require 'rails_helper'

RSpec.describe "質問作成", type: :system do
  before do
    @question = FactoryBot.build(:question)
    # 生徒ユーザー作成
    student = FactoryBot.create(:user)
    # 質問を持つユーザーを生徒ユーザーに変更
    @question.user = student
  end

  context "質問作成できる場合" do
    it "生徒が自身の質問を作成できる" do
      # 生徒ユーザーでログイン
      sign_in(@question.user)
      # 質問一覧ページに遷移
      click_on "質問一覧"
      sleep 0.1
      expect(current_path).to eq(questions_path)
      # タイトルを入力して送信、Resultモデルカウント確認
      fill_in "question_title", with: @question.title
      expect{
        find('input[name="commit"]').click
        sleep 0.1
      }.to change{Question.count}.by(1)
      # 適切に表示されていることを確認
      expect(page).to have_current_path(questions_path)
      expect(page).to have_selector(".header", text: @question.user.last_name)
      expect(page).to have_selector(".question_list", text: @question.title)
      expect(page).to have_selector(".question_list", text: @question.user.last_name)
    end
  end

  context "質問作成できない場合" do
    it "入力に不備があると作成できない" do
      # 生徒ユーザーでログイン
      sign_in(@question.user)
      # 質問一覧ページに遷移
      click_on "質問一覧"
      sleep 0.1
      expect(current_path).to eq(questions_path)
      # タイトルを入力せず送信、Resultモデルカウント確認
      expect{
        find('input[name="commit"]').click
        sleep 0.1
      }.to change{Question.count}.by(0)
      # 質問一覧ページに戻り、エラーメッセージが表示される
      expect(page).to have_current_path(questions_path)
      expect(page).to have_content("Title can't be blank")
    end

    it "先生は質問作成できない" do
      # 先生ユーザーでログイン
      teacher = FactoryBot.create(:user_teacher)
      sign_in(teacher)
      # 質問一覧ページに遷移
      click_on "質問一覧"
      sleep 0.1
      expect(current_path).to eq(questions_path)
      # 質問作成フォームがない
      expect(page).not_to have_content("質問作成")
      expect(page).not_to have_button("作成")
    end

    it "ログインしていないと質問作成できない" do
      visit root_path
      expect(page).not_to have_content("質問一覧")
    end
  end
end

describe "質問チャット" do
  before do
    @message = "specメッセージ"
    @question = FactoryBot.create(:question)
  end

  context "メッセージ送信できる場合" do
    it "生徒が自身の質問チャットでメッセージ送信できる" do
      # 生徒ユーザーでログイン
      sign_in(@question.user)
      # 質問一覧ページに遷移
      click_on "質問一覧"
      sleep 0.1
      expect(current_path).to eq(questions_path)
      # メッセージ一覧ページに遷移
      click_on @question.title
      sleep 0.1
      expect(current_path).to eq(question_messages_path(@question))
      # メッセージを入力して送信、Messageモデルカウント確認
      fill_in "message_text", with: @message
      expect{
        find('input[name="commit"]').click
        sleep 0.1
      }.to change{Message.count}.by(1)
      # 適切に表示されていることを確認(メッセージ一覧ページ)
      expect(page).to have_current_path(question_messages_path(@question))
      expect(page).to have_selector(".header", text: @question.user.last_name)
      expect(page).to have_selector(".page_heading", text: @question.title)
      expect(page).to have_selector(".page_heading", text: "by #{@question.user.last_name}")
      expect(page).to have_selector(".question_list", text: @message)
      expect(page).to have_selector(".question_list", text: "by #{@question.user.last_name}")
    end
  end
end
