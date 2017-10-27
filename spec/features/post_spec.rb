#integration spec using capybara

require 'rails_helper'

describe 'navigate' do
  before do
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
      visit new_post_path
  end

  describe 'index' do
    it 'can be reached successfully' do
      visit posts_path
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      visit posts_path
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of posts' do
      post1 = FactoryGirl.create(:post)
      p post1
      post2 = FactoryGirl.create(:second_post)
      p post2
      expect(page).to have_content(/post1|post1|/)
    end
  end

  describe 'creation' do
    it 'has a new form that can be reached' do

      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Because I can!"

      click_on "Save"

      expect(page).to have_content("Because I can!")
    end

    it 'will have a user associated with it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User_Association"

      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("User_Association")
    end
  end
end
