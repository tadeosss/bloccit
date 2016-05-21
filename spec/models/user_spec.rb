require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }

  # Documentation for Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
  
  describe "attributes" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should respond_to(:role) }
    it { should respond_to(:admin?) }
    it { should respond_to(:member?) }
    it { should respond_to(:moderator?) }
  end
    
  # Not sure what the equivalent are for these RSpec to Shoulda Matchers...

  describe "roles" do

    it "is member by default" do
      expect(user.role).to eql("member")
    end
 
    context "member user" do
      it "returns true for #member?" do
        expect(user.member?).to be_truthy
      end
 
      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
      
      it "returns false for #moderator?" do
        expect(user.moderator?).to be_falsey
      end
      
    end
 
    context "admin user" do
      before do
        user.admin!
      end
 
      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end
 
      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
      
      it "returns false for #moderator?" do
        expect(user.moderator?).to be_falsey
      end
      
    end
    
    context "moderator user" do
      before do
        user.moderator!
      end
 
      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end
 
      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
      
      it "returns true for #moderator?" do
        expect(user.moderator?).to be_truthy
      end
    end
    
  end

  describe 'validations' do
    
    # Not sure how to translate two lines below to Shoulda. They came from Ch. 45.
    let(:user_with_invalid_name) { build(:user, name: "") }
    let(:user_with_invalid_email) { build(:user, email: "") }
     
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(1) }

    it { is_expected.to validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:email).is_at_least(3) }
    
    # I think this test is not a proper shoulda matcher test
    it { is_expected.to allow_value("user@bloccit.com").for(:email) }

    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to have_many(:posts)}
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:votes) }
    it { is_expected.to have_many(:favorites) }
  end

  describe "#favorite_for(post)" do
    before do
      topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
    end
  
    it "returns `nil` if the user has not favorited the post" do
      expect(user.favorite_for(@post)).to be_nil
    end
  
    it "returns the appropriate favorite if it exists" do
      favorite = user.favorites.where(post: @post).create
      expect(user.favorite_for(@post)).to eq(favorite)
    end
  end

  describe ".avatar_url" do
    let(:known_user) { create(:user, email: "blochead@bloc.io") }

    it "returns the proper Gravatar url for a known email entity" do
      expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
      expect(known_user.avatar_url(48)).to eq(expected_gravatar)
    end
  end
  
  describe "#generate_auth_token" do
    it "creates a token" do
      expect(user.auth_token).to_not be_nil
    end
  end
  
end
