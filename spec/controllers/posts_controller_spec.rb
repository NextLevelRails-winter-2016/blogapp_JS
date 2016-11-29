require 'rails_helper'

RSpec.describe PostsController, type: :controller do

	describe "GET #index" do

		it 'renders the index template' do
		get :index

		  expect(response).to render_template(:index)
		end
	

		it 'returns all posts for user' do
		   user = create(:user)

		   get :index

		   expect(assigns(:posts)).not_to be_nil
		end
	end

	describe 'GET #new' do

	  it 'renders the new template' do
	    get :new
	    expect(response).to render_template(:new)
	  end

	  it "assigns a new post to @post" do
	    get :new
	    expect(assigns(:post)).to be_a_new(Post)
	  end

	end

	describe "GET #show" do

	    it 'assigns the requested post to @post' do
	      post = create(:election)

	      get :show, params: {id: post.to_param}

	      expect(assigns(:post)).to eq(post)
	    end

	    it 'renders the :show template' do
	      post = create(:thanksgiving)

	      get :show, params: {id: post.to_param}
	      expect(response).to render_template(:show)
	    end
  	end

  	describe 'GET #edit' do

	    it "assigns the requested post as @post" do
	      post = create(:election)

	      get :edit, params: {id: post.to_param}

	      expect(assigns(:post)).to eq(post)
	    end

	    it "renders the :edit template" do
	      post = create(:thanksgiving)
	      get :edit, params: { id: post.to_param }
	      expect(response).to render_template :edit
	    end

	end

	describe "POST #create" do

		let(:user) {create(:user)}
  		let(:valid_attributes) { attributes_for(:election, user_id: user.id) }
 		let(:invalid_attributes) { attributes_for(:invalid_post)}

		context "with valid attributes" do

		    it 'persists new post' do
		    	expect{
     				post :create, params: {post: valid_attributes}
  				}.to change(Post, :count).by(1)
  			end

  			it 'redirects to show page' do
	        	post :create, params: { post: valid_attributes}
	        	expect(response).to redirect_to(assigns(:post))
	    	end

		end

		context 'with invalid attributes' do

			it 'does not persist post' do
		    	expect{
		      	post :create, params: {post: invalid_attributes}
		    	}.not_to change(Post, :count)
		  	end

			it 're-renders :new template' do
			    post :create, params: {post: invalid_attributes}
			    expect(response).to render_template(:new)
			end
		end
	end

	describe '#PATCH #update' do
		let(:post) { create(:election) }
		let(:new_attributes) { attributes_for(:thanksgiving) }
		let(:invalid_attributes) { attributes_for(:invalid_post)}

		context 'with valid params' do

		    it 'updates the selected post' do
		      patch :update, params: { id: post.to_param, post: new_attributes }

		      post.reload

		      expect(post.title).to eq('thanksgiving')
		      expect(post.article).to eq('cannot wait to eat turkey')
		    end

		    it 'redirects to the post' do
		      patch :update, params: { id: post.to_param, post: new_attributes }
		      post.reload

		      expect(response).to redirect_to(post)
		    end
  		end

  		context 'with invalid params' do
		    it 'does not update the post' do
		      patch :update, params: {id: post.to_param, post: invalid_attributes}
		      expect(assigns(:post)).to eq(post)
		    end

		    it 're-renders the edit template' do
		      patch :update, params: {id: post.to_param, post: invalid_attributes}
		      expect(response).to render_template(:edit)
    		end
  		end
  	end

  	describe "DELETE #destroy" do
		let(:post) {build(:election)}

		it "destroys the requested post" do
			post.save
			expect {
		  		delete :destroy, params: {id: post.to_param}
			}.to change(Post, :count).by(-1)
		end

		it "redirects to the tasks list" do
			post.save
			delete :destroy, params: {id: post.to_param}
			expect(response).to redirect_to(posts_path)
		end
	end
end
