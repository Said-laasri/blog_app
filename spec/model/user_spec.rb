require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  before { subject.save }

  it 'name should be presnet' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should be long' do
    subject.name = 't'
    expect(subject).to_not be_valid
  end

  it 'post counter should be greater or equal to zero' do
    subject.posts_counter = '-1'
    expect(subject).to_not be_valid
  end

  it 'post count should be interger' do
    subject.posts_counter = 'afgw'
    expect(subject).to_not be_valid
  end

  it 'photo should be present' do
    subject.photo = nil
    expect(subject).to_not be_valid
  end

  it 'bio should be present' do
    subject.bio = nil
    expect(subject).to_not be_valid
  end

  it 'bio should be long' do
    subject.bio = 't'
    expect(subject).to_not be_valid
  end

  it 'it should have post freater then or equal to 0' do
    subject.posts_counter = 0
    expect(subject).to be_valid
  end

  describe 'Should test recent post method' do
    before { 4.times { |post_number| Post.create(author_id: subject.id, title: "this is the post #{post_number}") } }

    it 'User should have three recent posts' do
      expect(subject.recent_posts).to eq(subject.posts.last(3))
    end
  end
end
