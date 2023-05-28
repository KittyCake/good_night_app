require 'rails_helper'

RSpec.describe SleepRecordsController, type: :controller do
  let(:user) { create(:user) }
  let(:followed_user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:follow) { create(:follow, follower: user, followed_user: followed_user) }
  let!(:followed_user_sleep_record) { create(:sleep_record, user: followed_user) }
  let!(:another_user_sleep_record) { create(:sleep_record, user: another_user) }

  describe 'GET #index' do
    it 'returns all sleep records' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(2)
    end
  end

  describe 'POST #create' do
    let(:sleep_record_params) do
      {
        sleep_record: {
          started_at: 1.hour.ago,
          ended_at: Time.now,
          user_id: user.id
        }
      }
    end

    it 'creates a new sleep record' do
      expect { post :create, params: sleep_record_params }.to change(SleepRecord, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET #followings_records' do
    let(:params) do
      {
        sleep_record: {
          user_id: user.id
        }
      }
    end

    it 'returns the sleep records of the user’s followed users' do
      get :followings_records, params: params
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(1)
      expect(json_response.first['user_id']).to eq(followed_user.id)
    end

    context 'when user does not exist' do
      let(:invalid_params) do
        {
          sleep_record: {
            user_id: -1
          }
        }
      end

      subject { get :followings_records, params: invalid_params }

      it 'returns an error' do
        expect(subject).to have_http_status(:not_found)
      end
    end
  end
end
