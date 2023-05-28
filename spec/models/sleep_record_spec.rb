require 'rails_helper'

RSpec.describe SleepRecord, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:started_at) }
    it { should validate_presence_of(:ended_at) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe '#duration' do
    let(:sleep_record) { create(:sleep_record, started_at: 1.hour.ago, ended_at: Time.now) }

    it 'returns the duration of sleep' do
      expect(sleep_record.duration).to be_within(0.1).of(1.hour)
    end
  end

  describe '#end_after_start' do
    context 'when ended_at is before started_at' do
      let(:sleep_record) { build(:sleep_record, started_at: Time.now, ended_at: 1.hour.ago) }

      it 'is not valid' do
        expect(sleep_record.valid?).to be_falsey
      end

      it 'adds an error on ended_at' do
        sleep_record.valid?
        expect(sleep_record.errors.details[:ended_at][0][:error]).to eq 'must be after started_at'
      end
    end

    context 'when ended_at is after started_at' do
      let(:sleep_record) { build(:sleep_record, started_at: 1.hour.ago, ended_at: Time.now) }

      it 'is valid' do
        expect(sleep_record.valid?).to be_truthy
      end
    end
  end
end
