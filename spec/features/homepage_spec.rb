require 'rails_helper'

describe 'Homepage' do

  it 'allows the admin to approve posts from the home page' do
    post = FactoryGirl.create(:post)
    admin_user = FactoryGirl.create(:admin_user)

    login_as(admin_user, :scope => :user)

    visit root_path

    click_on("Approve")

    expect(post.reload.status).to eq('approved')
  end

end
