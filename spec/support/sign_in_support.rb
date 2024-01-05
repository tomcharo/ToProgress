module SignInSupport
  def sign_in(user)
    name = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    visit "http://#{name}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{root_path}"

    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    find('input[name="commit"]').click
    sleep 0.1
    expect(page).to have_current_path(root_path)
    expect(page).to have_content(user.grade.name)
  end
end