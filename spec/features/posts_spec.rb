require 'rails_helper'

feature "posts/index" do
  scenario "renders a list of posts" do
    user = create(:user_with_posts)
    sign_in(user)

    create(:election)
    create(:thanksgiving)

    visit posts_path

    expect(page).to have_content('Trump')
    expect(page).to have_content('turkey')
  end
end

feature 'New Task' do
  scenario 'user adds a new post' do
    user = create(:user)
    sign_in(user)
    visit posts_path

    expect{
      click_link 'New Post'
      fill_in 'Title', with: 'My New Post'
      fill_in 'Article', with: 'my new article'
      select(user.email, from: 'post_user_id')
      click_button('Create Post')
    }.to change(Post, :count).by(1)

    expect(current_path).to eq(post_path(Post.last.id))
    expect(page).to have_content('My New Post')

  end
end

feature 'Edit Post' do

  let(:user) {create(:user)}
  let(:post) { create(:thanksgiving)}

  scenario 'User edits post' do
    sign_in(user)
    visit post_path(post)
    expect(page).to have_content('thanksgiving')

    click_link("Edit")

    fill_in 'Title', with: 'Edited Title'
    fill_in "Article", with: 'Edited article'
    select(post.user.email, from: 'post_user_id')

    click_button('Update Post')

    expect(current_path).to eq(post_path(post.id))

    expect(page).to have_content('Edited article')
  end
end