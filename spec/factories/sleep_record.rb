FactoryBot.define do
  factory :sleep_record do
    association :user
    started_at { 1.day.ago }
    ended_at { Time.now }
  end
end
