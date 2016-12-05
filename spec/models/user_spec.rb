require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build_stubbed(:user)}
  let(:user_with_posts) { build(:user_with_posts)}

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  it 'is invalid without firstname' do
   user.firstname = nil
   expect(user).not_to be_valid
  end

  it 'is invalid without lastname' do
   user.lastname = nil
   expect(user).not_to be_valid
  end

  it 'has many posts' do
   expect(user_with_posts.posts.length).to eq(2)
  end

  it 'returns posts created today' do
    # post = user_with_posts.posts.first

    # allow(post).to receive(:created_at).and_return(DateTime.tomorrow)

    expect(user_with_posts.post_today.length).to eq(2)
  end

end