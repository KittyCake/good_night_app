FactoryBot.define do
  factory :follow do
    association :follower, factory: :user, username: 'follower'
    association :followed_user, factory: :user, username: 'followed'
  end
end