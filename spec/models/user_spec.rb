require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:sleep_records).dependent(:destroy) }
    it { should have_many(:followings).dependent(:destroy) }
    it { should have_many(:followers).dependent(:destroy) }
    it { should have_many(:followed_users) }
    it { should have_many(:follower_users) }
  end
end
