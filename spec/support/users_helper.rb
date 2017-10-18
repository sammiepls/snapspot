module UsersHelper

  def login(user)
    visit login_path
    fill_in 'session[username]', with: user.username
    fill_in 'session[password]', with: user.password
    click_button 'Login'
  end

  def logout(user)
    visit root_path
    click_link 'Log Out'
  end

end
