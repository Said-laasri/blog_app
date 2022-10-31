require 'rails_helper'

RSpec.describe 'User', type: :system do
  # describe 'index page' do
  #   it 'i can see the names of all users' do
  #     visit "/"
  #     expect(page).to have_content(User.first.name)
  #   end
  # end

  describe 'index page' do
    it 'i can see the number of post for each user' do
      visit "/"
      expect(page).to have_content(User.posts_counter)
    end
  end
end