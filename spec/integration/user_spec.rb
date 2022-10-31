require 'rails_helper'

RSpec.describe 'User', type: :system do
    describe 'index page' do
      it 'i can see the names of all users' do
        visit "/"
        expect(page).to has_content?(User.all.name)
      end
    end
  end