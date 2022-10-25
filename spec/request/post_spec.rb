require 'rails_helper'

# testting post controllers

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:example) do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                         posts_counter: 0)
      get "/users/#{user.id}/posts"
    end

    it 'it renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'should return 200' do
      expect(response).to have_http_status(:ok)
    end

    it ' should return place holder' do
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end
end

RSpec.describe PostsController, type: :request do
  describe 'GET show' do
    before(:example) do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                         posts_counter: 0)
      post = Post.create(author: user, title: 'Hello', text: 'This is my first post', likes_counter: 0,
                         comments_counter: 0)
      get "/users/#{user.id}/posts/#{post.id}"
    end

    it 'it renders the show template' do
      expect(response).to render_template('show')
    end

    it 'should return 200' do
      expect(response).to have_http_status(:ok)
    end

    it ' should return place holder' do
      expect(response.body).to include('showing list of posts for a given user')
    end
  end
end
