require 'rails_helper'

feature 'Create new user' do
  scenario 'without admin privileges' do
    user = create(:user)

    sign_in(user.email, user.password)
    visit admin_users_path

    expect(page).to have_content('You must be an admin to perform that action')
  end

  scenario 'with admin privileges' do
    user = create(:user, :admin)

    sign_in(user.email, user.password)
    visit admin_users_path

    click_on 'Create a New User'

    fill_in 'user[first_name]', with: 'Jean'
    fill_in 'user[last_name]', with: 'Smith'
    fill_in 'user[email]', with: 'nurse@email.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    check 'user_roles_nurse'

    click_on 'Create User'

    expect(page).to have_content 'nurse@email.com'
    expect(page).to have_content 'nurse'
  end
end
