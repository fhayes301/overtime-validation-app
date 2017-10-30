#integration spec using capybara

require 'rails_helper'

describe 'Navigate' do
  before do
      @user = FactoryGirl.create(:user)
      login_as(@user, :scope => :user)
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
      post1 = FactoryGirl.build_stubbed(:post)
      post2 = FactoryGirl.build_stubbed(:second_post)
      expect(page).to have_content(/post1|post1|/)
    end

    it 'has a scope so that only post creaters can see their posts' do
      post1 = Post.create(date: Date.today, rationale: "asdf", user_id: @user.id )
      post2 = Post.create(date: Date.today, rationale: "asdf", user_id: @user.id )

      other_user = User.create({first_name: "Non", last_name: "Authorized",
        email: "nonauth@user.com", password: "password", password_confirmation: "password"})
      post_from_another_user = Post.create(date: Date.today, rationale: "This post shouldn't be here", user_id: other_user.id )

      visit posts_path

      expect(page).to_not have_content(/This post shouldn't be here/)
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

  describe 'new' do
    it 'has a link from the homepage' do
      visit root_path
      click_link ("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'edit' do
    before do
      # @post = FactoryGirl.create(:post)
      @edit_user = User.create(first_name: "asdf", last_name: "jkl;", email: "asdfjkl;@test.com", password: "password", password_confirmation: "password")
      login_as(@edit_user, :scope => :user)
      @edit_post = Post.create(date: Date.today, rationale: "asdf", user_id: @edit_user.id)
    end

    it "can be edited" do
      visit edit_post_path(@edit_post)
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "New Content"
      click_on "Save"
      expect(page).to have_content("New Content")
    end

    it 'cannot be edited by a non authorized user' do
      logout(:user)
      non_authorized_user = FactoryGirl.create(:non_authorized_user)
      login_as(non_authorized_user, :scope => :user)

      visit edit_post_path(@edit_post)

      expect(current_path).to eq(root_path)
    end
  end

  describe 'delete' do
    it 'can delete a post' do
      @post = FactoryGirl.create(:post)
      @post.update(user_id: @user.id)
      visit posts_path
      click_link ("delete_post_#{@post.id}_from_index")
      expect(page.status_code).to eq(200)
    end
  end

end
