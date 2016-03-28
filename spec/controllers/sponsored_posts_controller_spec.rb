require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do
	
	let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  
	let(:my_sponsored_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

#NEW Sponsored Posts

	 describe "GET new" do
		it "returns http success" do
			get :new
			expect(response).to have_http_status(:success)
		end
 
		it "renders the #new view" do
			get :new
			expect(response).to render_template :new
		end
 
		it "instantiates @sponsored_post" do
			get :new
			expect(assigns(:sponsored_post)).not_to be_nil
		end
	 end
 
	 describe "POST create" do
		it "increases the number of Post by 1" do
			expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(SponsoredPost,:count).by(1)
		end
 
		it "assigns the new post to @sponsored_post" do
			post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
			expect(assigns(:sponsored_post)).to eq SponsoredPost.last
		end
 
		it "redirects to the new post" do
			post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
			expect(response).to redirect_to SponsoredPost.last
		end
	end

#SHOW Sponsored Posts

	describe "GET show" do
    it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #show view" do
      get :show, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      get :show, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(assigns(:sponsored_post)).to eq(my_sponsored_post)
    end
  end

#EDIT Sponsored Posts

  describe "GET edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_sponsored_post.id
    end
  
    it "renders the #edit view" do
      get :edit, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(response).to render_template :edit
    end

    it "assigns post to be updated to @post" do
      get :edit, topic_id: my_topic.id, id: my_sponsored_post.id
      post_instance = assigns(:post)
      expect(post_instance.id).to eq my_sponsored_post.id
      expect(post_instance.title).to eq my_sponsored_post.title
      expect(post_instance.body).to eq my_sponsored_post.body
    end
	end
	
	describe "PUT update" do
		it "updates sponsored post with expected attributes" do
			new_title = RandomData.random_sentence
			new_body = RandomData.random_paragraph
			put :update, id: my_sponsored_post.id, post: {title: new_title, body: new_body}
			updated_post = assigns(:post)
			expect(updated_post.id).to eq my_sponsored_post.id
			expect(updated_post.title).to eq new_title
			expect(updated_post.body).to eq new_body
		end
		
		it "redirects to the updated post" do
			new_title = RandomData.random_sentence
			new_body = RandomData.random_paragraph
			put :update, id: my_sponsored_post.id, post: {title: new_title, body: new_body}
			expect(response).to redirect_to my_sponsored_post
		end
	end

end
