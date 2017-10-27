require 'rails_helper'

describe 'admin dasboard' do

  it 'does not allow users to access without being signed in' do
    visit admin_root_path
    expect(page.current_path).to eq(new_user_session_path)
  end

  it 'cannot be reached by non-admin users' do
    user = FactoryGirl.create(:user)
    login_as(user, :score => :user)

    visit admin_root_path

    expect(current_path).to eq(root_path)
  end

  it 'can be reaced by admin users' do
    admin_user = FactoryGirl.create(:admin_user)
    login_as(admin_user, :score => :user)

    visit admin_root_path

    expect(current_path).to eq(admin_root_path)
  end

end
