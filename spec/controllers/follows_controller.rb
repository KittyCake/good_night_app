require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  let(:follower) { create(:user) }
  let(:followed_user) { create(:user) }
  let(:follow_params) do
    {
      follow: {
        follower_id: follower.id,
        followed_user_id: followed_user.id
      }
    }
  end

  describe 'POST #create' do
    subject { post :create, params: follow_params }

    context 'when valid' do
      it 'creates a new follow' do
        expect { subject }.to change(Follow, :count).by(1)
        expect(Follow.last.follower).to eq(follower)
        expect(Follow.last.followed_user).to eq(followed_user)
      end
    end

    context 'when follower_id is missing' do
      before { follow_params[:follow][:follower_id] = nil }

      it 'returns a not found status' do
        subject
        expect(response).to have_http_status(:not_found)
      end

      it 'does not create a new follow' do
        expect { subject }.not_to change(Follow, :count)
      end
    end

    context 'when followed_user_id is missing' do
      before { follow_params[:follow][:followed_user_id] = nil }

      it 'returns a not found status' do
        subject
        expect(response).to have_http_status(:not_found)
      end

      it 'does not create a new follow' do
        expect { subject }.not_to change(Follow, :count)
      end
    end
  end

  describe 'DELETE #destroy_by_user_ids' do
    let!(:follow) { create(:follow, follower: follower, followed_user: followed_user) }
    subject { delete :destroy_by_user_ids, params: follow_params }

    context 'when valid' do
      it 'destroys the follow' do
        expect { subject }.to change(Follow, :count).by(-1)
      end
    end

    context 'when followed_user_id is missing' do
      before { follow_params[:follow][:followed_user_id] = nil }

      it 'raises an ActiveRecord::RecordNotFound error' do
        expect(subject).to have_http_status(:not_found)
      end
    end
  end
end
