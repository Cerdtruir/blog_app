require_relative '../rails_helper'
require_relative '../spec_helper'

describe 'sign in page', type: :feature do
  context 'Does login page load' do
    it 'displays the input labels' do
      visit '/users/sign_in'
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
    end
    it 'dsiplays the log in button' do
      visit '/users/sign_in'
      expect(page).to have_content('Log in')
    end
  end

  context 'Logging in' do
    it 'shows error when empty username and password' do
      visit '/users/sign_in'

      click_button 'Log in'

      expect(page).to have_content('Invalid Email or password.')
    end
    it 'shows error when incorrect details' do
      visit '/users/sign_in'

      fill_in 'Email',	with: 'adasd@sdfsd.sdfsd'
      fill_in 'Password',	with: 'asdfasdf'

      click_button 'Log in'

      expect(page).to have_content('Invalid Email or password.')
    end

    it 'logs in when submitting correct details' do
      user = User.create(email: 'useasdasd1231r@example.com', password: 'password', name: 'Example User',
                         posts_counter: 0)
      user.confirm

      visit '/users/sign_in'

      fill_in('Email', with: 'useasdasd1231r@example.com')
      fill_in('Password', with: 'password')

      click_button 'Log in'

      expect(page).to have_content('Signed in successfully.')
    end
  end
end
