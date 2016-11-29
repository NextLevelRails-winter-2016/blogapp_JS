require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user) }
  let(:user_with_posts) { build(:user_with_posts) }

  it "has a valid factory" do
  	expect(build(:user)).to be_valid
  end

  it "is valid with valid attributes" do
  	user = create(:user)
  	expect(user).to be_valid
  end

  it "is invalid without username" do
  	user = build(:user, username: nil)
  	expect(user).not_to be_valid
  end

  it "is invalid without email" do
  	user = build(:user, email: nil)
  	expect(user).not_to be_valid
  end

  it "has two posts" do
  	user = build(:user)
  	expect(user_with_posts.posts.length).to eq(2)
  end
end
