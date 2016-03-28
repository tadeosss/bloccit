class SponsoredPostsController < ApplicationController
  
  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end
  
  def new
    @sponsored_post = SponsoredPost.new
  end
  
  def create
    @sponsored_post = SponsoredPost.new
    @sponsored_post.title = params[:post][:title]
    @sponsored_post.body = params[:post][:body]
    
    if @sponsored_post.save
      flash[:notice] = "Post was saved."
      redirect_to @sponsored_post
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end
  
  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end
  
end
