require 'rails_helper'
# test controlers

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    before(:example) do
      get '/users'
    end

    context 'valid Authorization header' do
      it 'it renders the index template' do
        expect(response).to render_template('index')
      end
    end

    context 'expect response to be succesful' do
      it 'should return 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'expect to return placeholder' do
      it ' should return place holder' do
        # get :index
        expect(response.body).to include('Users List')
      end
    end
  end
end

# Path: spec/Request/user_spec.rb

RSpec.describe UsersController, type: :request do
  describe 'GET show' do
    before(:example) do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                         posts_counter: 0)
      get "/users/#{user.id}"
    end

    it 'it renders the show template' do
      expect(response).to render_template('show')
    end

    it 'should return 200' do
      expect(response).to have_http_status(:ok)
    end

    it ' should return place holder' do
      expect(response.body).to include('Show users pages')
    end
  end
end
