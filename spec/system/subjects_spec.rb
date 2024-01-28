require 'rails_helper'

RSpec.describe "科目登録", type: :system do
  before do
    @subject = FactoryBot.build(:subject)
    # 成績作成
    result = FactoryBot.create(:result)
    @subject.result = result
    # 先生ユーザー作成
    @teacher = FactoryBot.create(:user_teacher)
  end

  context "科目登録できる場合" do
    it "生徒が自身の成績の科目を登録できる" do
      # 生徒ユーザーでログイン
      sign_in(@subject.result.user)
      # 成績一覧ページに遷移
      click_on "成績一覧"
      sleep 0.1
      expect(current_path).to eq(student_results_path(@subject.result.user))
      # 成績詳細ページに遷移
      click_on @subject.result.name
      sleep 0.1
      expect(current_path).to eq(student_result_path(@subject.result.user, @subject.result))
      # 科目登録ページに遷移
      click_on "編集"
      sleep 0.1
      expect(current_path).to eq(new_student_result_subject_path(@subject.result.user, @subject.result))
      # 値を入力して送信、Subjectモデルカウント確認
      fill_in "subject_name", with: @subject.name
      fill_in "subject_score", with: @subject.score
      fill_in "subject_max_score", with: @subject.max_score
      fill_in "subject_average_score", with: @subject.average_score
      fill_in "subject_rank", with: @subject.rank
      fill_in "subject_rank_range", with: @subject.rank_range
      expect{
        find('input[value="保存"]').click
        sleep 0.1
      }.to change{Subject.count}.by(1)
      # 適切に表示されていることを確認(科目登録ページ)
      expect(current_path).to eq(new_student_result_subject_path(@subject.result.user, @subject.result))
      expect(page).to have_selector(".header", text: @subject.result.user.last_name)
      expect(page).to have_selector(".main_right", text: @subject.result.name)
      expect(page).to have_content(@subject.name)
      # 成績詳細ページに遷移
      click_on "終了"
      sleep 0.1
      expect(current_path).to eq(student_result_path(@subject.result.user, @subject.result))
      expect(page).to have_content(@subject.name)
    end

    it "先生が生徒の成績の科目を登録できる" do
      # 先生ユーザーでログイン
      sign_in(@teacher)
      # 生徒一覧ページに遷移
      click_on "生徒一覧"
      sleep 0.1
      expect(current_path).to eq(students_path)
      # 生徒の成績一覧ページに遷移
      click_on @subject.result.user.last_name
      sleep 0.1
      expect(current_path).to eq(student_results_path(@subject.result.user))
      # 成績詳細ページに遷移
      click_on @subject.result.name
      sleep 0.1
      expect(current_path).to eq(student_result_path(@subject.result.user, @subject.result))
      # 科目登録ページに遷移
      click_on "編集"
      sleep 0.1
      expect(current_path).to eq(new_student_result_subject_path(@subject.result.user, @subject.result))
      # 値を入力して送信、Subjectモデルカウント確認
      fill_in "subject_name", with: @subject.name
      fill_in "subject_score", with: @subject.score
      fill_in "subject_max_score", with: @subject.max_score
      fill_in "subject_average_score", with: @subject.average_score
      fill_in "subject_rank", with: @subject.rank
      fill_in "subject_rank_range", with: @subject.rank_range
      expect{
        find('input[value="保存"]').click
        sleep 0.1
      }.to change{Subject.count}.by(1)
      # 適切に表示されていることを確認(科目登録ページ)
      expect(current_path).to eq(new_student_result_subject_path(@subject.result.user, @subject.result))
      expect(page).to have_selector(".header", text: @teacher.last_name)
      expect(page).to have_selector(".main_right", text: @subject.result.user.last_name)
      expect(page).to have_selector(".main_right", text: @subject.result.name)
      expect(page).to have_content(@subject.name)
      # 成績詳細ページに遷移
      click_on "終了"
      sleep 0.1
      expect(current_path).to eq(student_result_path(@subject.result.user, @subject.result))
      expect(page).to have_content(@subject.name)
    end
  end

  context "科目登録できない場合" do
    it "入力に不備があると登録できない" do
      # 生徒ユーザーでログイン
      sign_in(@subject.result.user)
      # 成績一覧ページに遷移
      click_on "成績一覧"
      sleep 0.1
      expect(current_path).to eq(student_results_path(@subject.result.user))
      # 成績詳細ページに遷移
      click_on @subject.result.name
      sleep 0.1
      expect(current_path).to eq(student_result_path(@subject.result.user, @subject.result))
      # 科目登録ページに遷移
      click_on "編集"
      sleep 0.1
      expect(current_path).to eq(new_student_result_subject_path(@subject.result.user, @subject.result))
      # 値を入力せず送信、Subjectモデルカウント確認
      expect{
        find('input[value="保存"]').click
        sleep 0.1
      }.to change{Subject.count}.by(0)
      # 科目登録ページでエラーメッセージが表示される
      expect(current_path).to eq(new_student_result_subject_path(@subject.result.user, @subject.result))
      expect(page).to have_selector(".header", text: @subject.result.user.last_name)
      expect(page).to have_selector(".main_right", text: @subject.result.name)
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Max score is not a number")
    end
  end
end


describe "科目編集,削除", type: :system do
  before do
    @subject = FactoryBot.create(:subject)
  end

  context "科目編集,削除できる場合" do
    it "科目編集できる" do
      # 生徒ユーザーでログイン
      sign_in(@subject.result.user)
      # 成績一覧ページに遷移
      click_on "成績一覧"
      sleep 0.1
      expect(current_path).to eq(student_results_path(@subject.result.user))
      # 成績詳細ページに遷移
      click_on @subject.result.name
      sleep 0.1
      expect(current_path).to eq(student_result_path(@subject.result.user, @subject.result))
      # 科目登録ページに遷移
      click_on "編集"
      sleep 0.1
      expect(current_path).to eq(new_student_result_subject_path(@subject.result.user, @subject.result))
      expect(page).to have_content(@subject.name)
      # 科目編集ページに遷移
      click_on "編集"
      sleep 0.1
      expect(current_path).to eq(edit_student_result_subject_path(@subject.result.user, @subject.result, @subject))
      # 値を編集して送信
      fill_in "subject_name", with: "spec科目編集"
      click_on "保存"
      sleep 0.1
      # 適切に表示されていることを確認(科目登録ページ)
      expect(current_path).to eq(new_student_result_subject_path(@subject.result.user, @subject.result))
      expect(page).to have_selector(".header", text: @subject.result.user.last_name)
      expect(page).to have_selector(".main_right", text: @subject.result.name)
      expect(page).to have_content("spec科目編集")
    end

    it "科目削除できる" do
      # 生徒ユーザーでログイン
      sign_in(@subject.result.user)
      # 成績一覧ページに遷移
      click_on "成績一覧"
      sleep 0.1
      expect(current_path).to eq(student_results_path(@subject.result.user))
      # 成績詳細ページに遷移
      click_on @subject.result.name
      sleep 0.1
      expect(current_path).to eq(student_result_path(@subject.result.user, @subject.result))
      # 科目登録ページに遷移
      click_on "編集"
      sleep 0.1
      expect(current_path).to eq(new_student_result_subject_path(@subject.result.user, @subject.result))
      expect(page).to have_content(@subject.name)
      # 科目編集ページに遷移
      click_on "編集"
      sleep 0.1
      expect(current_path).to eq(edit_student_result_subject_path(@subject.result.user, @subject.result, @subject))
      # データを削除、Subjectモデルカウント確認
      expect{
        click_on "削除"
        sleep 0.1
      }.to change{Subject.count}.by(-1)
      # 適切に表示されていることを確認(科目登録ページ)
      expect(current_path).to eq(new_student_result_subject_path(@subject.result.user, @subject.result))
      expect(page).to have_selector(".header", text: @subject.result.user.last_name)
      expect(page).to have_selector(".main_right", text: @subject.result.name)
      expect(page).not_to have_content(@subject.name)
    end
  end
end
