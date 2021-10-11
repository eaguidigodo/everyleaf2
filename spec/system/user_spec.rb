require 'rails_helper'
RSpec.describe 'User registration / login / logout function', type: :system do

  def user_login
    visit new_session_path
    fill_in 'session[email]', with: 'eaguidigodo@gmail.com'
    fill_in 'session[password]', with: 'anicetenselme'
    click_button 'Log in'
  end

  def admin_user_login
    visit new_session_path
    fill_in 'session[email]', with: 'wunderkind@gmail.com'
    fill_in 'session[password]', with: 'anicetenselme'
    click_button 'Log in'
  end

#*******************************
  describe 'User registration test' do
    context 'No user data and no login' do
      it 'Test of new user registration' do
        visit new_admin_user_path 
        fill_in 'user[username]', with: 'enso'
        fill_in 'user[email]', with: 'enso@gmail.com'
        fill_in 'user[password]', with: 'anicetenselme'
        fill_in 'user[password_confirmation]', with: 'anicetenselme'
        click_on "Signup"
        expect(page).to have_content 'Tasks'
      end
      it 'A test that jumps to the login screen when you are not logged in' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
#******************************
  describe 'Testing session functionality' do
    before do
      @user = FactoryBot.create(:user)
      @second_user = FactoryBot.create(:second_user)
      user_login
    end

    context 'If you have user data while you are not logged in' do
      it 'Being able to log in' do
        expect(page).not_to have_content 'There is no task created by this user'
      end
    end

    context 'Log in as a general user' do
      it 'You can jump to your details screen (My Page)' do
        click_link 'Profile'
         expect(page).to have_content 'eaguidigodo'
      end

   

      it 'Being able to log out' do
        click_link 'Logout'
        expect(current_path).to eq new_session_path
      end
    end
  end
# #******************************
  describe 'Manage screen test' do
    before do
      @user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:second_user)
    end

    context 'Log in as a general user' do
      it 'General users cannot access the manage screen' do
        user_login        
        visit admin_users_path
        expect(page).to have_content 'only the administrator can access it'
      end
    end

    context 'You are logged in as an administrator' do
      before do
        admin_user_login
        visit admin_users_path
      end 

      it 'Administrators should be able to access the manage screen' do
        expect(page).to have_content 'Task count'
      end

      it 'Administrators can register new users' do
        click_on 'New User'
        fill_in 'user[username]', with: 'serd'
        fill_in 'user[email]', with: 'serd@gmail.com'
        fill_in 'user[password]', with: 'anicetenselme'
        fill_in 'user[password_confirmation]', with: 'anicetenselme'
        click_on "Signup"

        visit admin_users_path
        expect(page).to have_content 'serd'
      end

      it 'The administrator can edit the user from the user edit screen' do
        click_on 'Edit'

        fill_in 'user[username]', with: 'serd edited'
        fill_in 'user[password]', with: 'anicetenselme'
        fill_in 'user[password_confirmation]', with: 'anicetenselme'
        click_on "Update"
        
        expect(page).to have_content 'New User'
      end

      it 'Administrators can delete users' do
        click_on 'Destroy'
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content "serd"
      end
    end
  end
end