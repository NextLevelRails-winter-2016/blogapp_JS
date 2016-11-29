require 'rails_helper'

RSpec.describe Post, type: :model do
  it "has a valid factory" do
  	expect(build(:post)).to be_valid
  end

  it "is valid with valid attributes" do
  	user = create(:post)
  	expect(user).to be_valid
  end

  it "is invalid without title" do
  	user = build(:post, title: nil)
  	expect(user).not_to be_valid
  end

  it "is invalid without article" do
  	user = build(:post, article: nil)
  	expect(user).not_to be_valid
  end

  it "belongs to user" do
  	expect(Post.reflect_on_association(:user).macro).to eq(:belongs_to)
  end
end
