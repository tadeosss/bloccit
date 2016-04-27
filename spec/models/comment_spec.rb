require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  describe "attributes" do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_db_column(:body).of_type(:text) }
  end
  
  describe 'associations' do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(5) }
  end

end