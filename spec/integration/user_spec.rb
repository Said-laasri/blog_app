require 'rails_helper'

RSpec.describe 'User', type: :system do
  describe 'index page' do
    before(:each) do
      @user = User.create(name: 'said', photo: 'https://media.tenor.com/TQ3Jul8r2DwAAAAC/anime-boy.gif',
                          bio: 'I am software enginner')
      @post = Post.create(author: @user, title: 'the unit tests', text: 'anything on unit tests')
      visit '/'
    end

    it 'i can see the names of all users' do
      expect(page).to have_content(User.first.name)
    end

    it 'i can see the number of post for each user' do
      expect(page).to have_content(@post.author.posts_counter)
    end

    it 'i can see the profile picture for each user' do
      expect(page.html).to include(@user.photo)
    end

    it 'When I click on a user, I am redirected to that users show page.' do
      click_on(@user.id.to_s)
      expect(page).to have_current_path("/users/#{@user.id}")
    end
  end

  describe 'show page' do
    before(:each) do
      @user = User.create(name: 'said', photo: 'https://media.tenor.com/TQ3Jul8r2DwAAAAC/anime-boy.gif',
                          bio: 'I am software enginner')
      Post.create(author: @user, title: 'ahmed', text: 'anything on unit tests')
      Post.create(author: @user, title: 'hamma', text: 'anything on unit tests')
      Post.create(author: @user, title: 'asim', text: 'anything on unit tests')
      @post = Post.create(author: @user, title: 'doe', text: 'anything on unit not tests')
      visit "/users/#{@user.id}"
    end
    it 'I can see the users profile picture' do
      expect(page.html).to include(@user.photo)
    end

    it 'I can see the users username.' do
      expect(page).to have_content(@user.name)
    end

    it 'I can see the number of posts the user has written' do
      expect(page).to have_content(@post.author.posts_counter)
    end

    it 'I can see the users bio' do
      expect(page).to have_content(@user.bio)
    end

    it 'I can see the users first 3 posts' do
      # count = @user.recent_posts.count
      # puts count
      expect(page).to have_content(@user.recent_posts[0].title)
      expect(page).to have_content(@user.recent_posts[1].title)
      expect(page).to have_content(@user.recent_posts[2].title)
      expect(page).to have_no_content(Post.where(author: @user).first.title)
    end

    it 'I can see a button that lets me view all of a users posts' do
      expect(page.find_button('See all Posts')).to have_content('See all Posts')
    end

    it 'When I click a users post, it redirects me to that posts show page' do
      click_on(@post.id.to_s)
      expect(page).to have_current_path("/users/#{@user.id}/posts")
    end

    it 'When I click to see all posts, it redirects me to the users posts index page.' do
      click_on('all-posts')
      expect(page).to have_current_path("/users/#{@user.id}/posts")
    end
  end
end
