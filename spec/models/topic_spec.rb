require 'rails_helper'

RSpec.describe Topic, type: :model do
  
  let(:topic) { create(:topic) }

  describe "attributes" do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:public).of_type(:boolean).with_options(default: true) }
    
    #I guess line below is RSpec syntax (from Ch. 45) and equivalent to Shoulda specs above? 
    #expect(topic).to have_attributes(name: topic.name, description: topic.description)

  end

  describe 'associations' do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:labelings) }
    it { should have_many(:labels).through(:labelings) }
  end
  
  describe "scopes" do
    before do
      @public_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @private_topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph, public: false)
    end
    
    describe "publically_viewable" do
      it "returns only public topics" do
        expect(Topic.publically_viewable).to eq([@public_topic])
      end
    end
    
    describe "privately_viewable" do
      it "returns only private topics" do
        expect(Topic.privately_viewable).to eq([@private_topic])
      end
    end

    describe "visible_to(user)" do
      it "returns all topics if the user is present" do
        user = User.new
        expect(Topic.visible_to(user)).to eq(Topic.all)
      end
  
      it "returns only public topics if user is nil" do
        expect(Topic.visible_to(nil)).to eq([@public_topic])
      end
    end
  end
  
end
