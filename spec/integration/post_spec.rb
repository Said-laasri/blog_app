require 'rails_helper'

RSpec.describe 'Post', type: :system do
  describe 'index page' do
    before(:each) do
      @user = User.create(name: 'said', photo: 'https://media.tenor.com/TQ3Jul8r2DwAAAAC/anime-boy.gif',
                          bio: 'I am software enginner')
      @post = Post.create(author: @user, title: 'the unit tests', text: 'anything on unit tests')
      visit "/users/#{@user.id}/posts"
    end

    it 'I can see the users profile picture.' do
      expect(page.html).to include(@user.photo)
    end

    it 'i can see the users name' do
      expect(page).to have_content(@user.name)
    end

    it 'i can see the number of post for each user' do
      expect(page).to have_content("Number of posts:#{@post.author.posts_counter}")
    end

    it 'I can see a posts title' do
      expect(page).to have_content(@post.title)
    end

    it 'I can see some of the posts body.' do
      expect(page).to have_content(@post.text)
    end

    it 'I can see the first comments on a post.' do
      expect(page).to have_content(@post.comments.first)
      expect(page).to have_content(@post.comments[1])
    end

    it 'I can see how many comments a post has' do
      expect(page.find("#comment#{@post.id}")).to have_content("Comments: #{@post.comments_counter}")
    end

    it 'I can see how many likes a post has' do
      expect(page.find("#like#{@post.id}")).to have_content("Likes: #{@post.likes_counter}")
    end

    it 'When I click a post, it redirects me to that posts show page' do
      click_on(@post.id.to_s)
      expect(page).to have_current_path("/users/#{@user.id}/posts/#{@post.id}")
    end

    it 'I can see a section for pagination if there are more posts than fit on the view.' do
      click_on('paginatation')
      expect(page).to have_current_path("/users/#{@user.id}/posts")
    end
  end

  describe 'show page' do
    before(:each) do
      @user = User.create(name: 'said', photo: 'https://media.tenor.com/TQ3Jul8r2DwAAAAC/anime-boy.gif',
                          bio: 'I am software enginner')
      @post = Post.create(author: @user, title: 'the unit tests', text: 'anything on unit tests')
      Comment.create(author: @user, post: @post, text: 'comment1')
      Comment.create(author: @user, post: @post, text: 'comment2')
      Like.create(author: @user, post: @post)
      Like.create(author: @user, post: @post)
      visit "/users/#{@user.id}/posts/#{@post.id}"
    end

    it 'I can see the posts title.' do
      expect(page).to have_content(@post.title)
    end

    it 'I can see who wrote the post.' do
      expect(page).to have_content(@user.name)
    end

    it ' I can see how many comments it has' do
      expect(page.find("#comment#{@post.id}")).to have_content("Comments:#{@post.comments_counter}")
    end

    it ' I can see how many likes it has' do
      expect(page.find("#like#{@post.id}")).to have_content("Likes:#{@post.likes_counter}")
    end

    it 'I can see some of the posts body.' do
      expect(page).to have_content(@post.text)
    end

    it 'I can see the username of each commentor.' do
      expect(page).to have_content(@post.comments.first.author.name)
      expect(page).to have_content(@post.comments[1].author.name)
    end

    it 'I can see the comment each commentor left.' do
      expect(page).to have_content(@post.comments.first.text)
      expect(page).to have_content(@post.comments[1].text)
    end
  end
end
