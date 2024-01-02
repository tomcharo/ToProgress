require 'rails_helper'

def basic_auth(path)
  name = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{name}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end


RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  it "新規登録に成功し、トップページに遷移する" do
    basic_auth root_path
    visit root_path
    click_on "新規登録"
    sleep 0.1
    expect(current_path).to eq(new_user_registration_path)
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    fill_in "user_password_confirmation", with: @user.password_confirmation
    fill_in "user[last_name]", with: @user.last_name
    fill_in "user[first_name]", with: @user.first_name
    select @user.grade.name, from: "user[grade_id]"
    expect{
      find('input[name="commit"]').click
      sleep 0.1
    }.to change{User.count}.by(1)
    expect(page).to have_current_path(root_path)
    expect(page).to have_content(@user.last_name)
    expect(page).to have_content(@user.first_name)
  end

  it "新規登録に失敗し、新規登録ページに戻る" do
    basic_auth root_path
    visit root_path
    click_on "新規登録"
    sleep 0.1
    expect(current_path).to eq(new_user_registration_path)
    expect{
      find('input[name="commit"]').click
      sleep 0.1
    }.to change{User.count}.by(0)
    expect(page).to have_current_path(new_user_registration_path)
    expect(page).to have_content("ログイン")
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  it "ログインに成功し、トップページに遷移する" do
    basic_auth root_path
    visit root_path
    click_on "ログイン"
    sleep 0.1
    expect(current_path).to eq(new_user_session_path)
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    find('input[name="commit"]').click
    sleep 0.1
    expect(page).to have_current_path(root_path)
    expect(page).to have_content(@user.last_name)
    expect(page).to have_content(@user.first_name)
  end

  it "ログインに失敗し、ログインページに戻る" do
    basic_auth root_path
    visit root_path
    click_on "ログイン"
    sleep 0.1
    expect(current_path).to eq(new_user_session_path)
    fill_in "user_email", with: "test"
    fill_in "user_password", with: "test"
    find('input[name="commit"]').click
    sleep 0.1
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content("ログイン")
  end
end
