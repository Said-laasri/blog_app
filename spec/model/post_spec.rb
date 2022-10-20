require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    author = User.create(name: 'Whatever', photo: 'http://google.com', bio: 'Hello! My name is King Josaphat.',
                         posts_counter: 0)
    subject do
      Post.new(title: 'This is first post', text: 'Hello! My name is King Josaphat.', author:, comments_counter: 2,
               likes_counter: 2)
    end

    before { subject.save }

    it 'author_title should be present' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'new post should have 0 comments' do
      subject.comments_counter = 0
      expect(subject.comments_counter).to eq(0)
    end

    it 'new post should have 0 likes' do
      subject.likes_counter = 0
      expect(subject.likes_counter).to eq(0)
    end

    describe 'Should test methods in post model' do
      it 'Post should have five recent comments' do
        expect(subject.recent_comment).to eq(subject.comments.last(5))
      end
    end
  end
end
