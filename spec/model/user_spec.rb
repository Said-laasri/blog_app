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
end