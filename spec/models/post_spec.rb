require 'rails_helper'

RSpec.describe Post, type: :model do

   let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
   let(:post) { topic.posts.create!(title: title, body: body, user: user) }

	it { is_expected.to have_many(:labelings) }
	it { is_expected.to have_many(:labels).through(:labelings) }
	it { is_expected.to have_many(:comments) }
		
  describe "attributes" do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:body).of_type(:text) }

  end
  
  describe 'associations' do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_many(:comments).dependent(:destroy) }
    it { should belong_to(:topic) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    #topic
    it { is_expected.to belong_to(:topic) }
    it { is_expected.to validate_presence_of(:topic) }
    #user
		it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:user) }
    #title
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(5) }
    #body
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(20) }
  end

end

