require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do

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
			get :show, {id: my_sponsored_post.id}
			expect(response).to have_http_status(:success)
		end
		
		it "renders the #show view" do
			get :show, {id: my_sponsored_post.id}
			expect(response).to render_template :show
		end
	
		it "assigns my_sponsored_post to @sponsored_post" do
			get :show, {id: my_sponsored_post.id}
			expect(assigns(:sponsored_post)).to eq(my_sponsored_post)
		end
	end

#EDIT Sponsored Posts

end
