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
  
end
