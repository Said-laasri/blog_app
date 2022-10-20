require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(author_id: '1', title: 'Hello World', text: 'This is my first post') }

  before { subject.save }

  it 'author_id should be present' do
    subject.id = nil
    expect(subject).to_not be_valid
  end

  it 'author_title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'author_title should be string' do
    subject.title = 123
    expect(subject).to_not be_valid
  end

  it 'author_text should be text' do
    subject.text = 123
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

end