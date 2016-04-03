require 'rails_helper'

RSpec.describe Topic, type: :model do

  describe "attributes" do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:public).of_type(:boolean).with_options(default: true) }
  end

  describe 'associations' do # Using Shoulda matchers http://matchers.shoulda.io/docs/v3.1.1/
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:sponsored_posts).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:name).is_at_least(5) }
    it { is_expected.to validate_length_of(:description).is_at_least(15) }
  end

end
