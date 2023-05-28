require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:follower) { create(:user) }
  let(:followed_user) { create(:user) }

  describe 'validations' do
    subject { build(:follow, follower: follower, followed_user: followed_user) }

    it { is_expected.to validate_presence_of(:follower) }
    it { is_expected.to validate_presence_of(:followed_user) }

    it 'should not allow a user to follow themselves' do
      self_follow = build(:follow, follower: follower, followed_user: follower)
      expect(self_follow).not_to be_valid
      expect(self_follow.errors[:base]).to include('User cannot follow themselves')
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:follower).class_name('User') }
    it { is_expected.to belong_to(:followed_user).class_name('User') }
  end
end
