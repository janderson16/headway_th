require 'rails_helper'

feature 'Edit existing user' do
  scenario 'without admin privileges' do
    user = create(:user)

    sign_in(user.email, user.password)
    visit admin_users_path

    expect(page).to have_content('You must be an admin to perform that action')
  end

  scenario 'with admin privileges' do
    create(:user)
    admin = create(:user, :admin)

    sign_in(admin.email, admin.password)
    visit admin_users_path

    within('table#users tr:nth-child(2)') do
      click_on 'Edit'
    end

    fill_in 'user[email]', with: 'new@email.com'
    check 'user_roles_nurse'
    check 'user_roles_admin'

    click_on 'Update'

    expect(current_path).to eq(admin_users_path)
    expect(page).to have_content 'new@email.com'
  end
end
