#integration spec using capybara

require 'rails_helper'

describe 'Navigate' do
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
      post2 = FactoryGirl.create(:second_post)
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

  describe 'edit' do
    before do
      @post = FactoryGirl.create(:post)
    end
    it "can be reached by clicking edit on index page" do
      post = FactoryGirl.create(:post)
      visit posts_path
      click_link ("edit_#{post.id}")
      expect(page.status_code).to eq(200)
    end

    it "can be edited" do
      visit edit_post_path(@post)
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "New Content"
      click_on "Save"
      expect(page).to have_content("New Content")
    end
  end
end
