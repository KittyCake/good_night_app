class User < ApplicationRecord
    has_many :sleep_records, dependent: :destroy
    has_many :active_relation, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
    has_many :passive_relation, class_name: 'Follow', foreign_key: 'followed_user_id', dependent: :destroy
    has_many :followed_users, through: :active_relation, source: :followed_user
    has_many :followers, through: :passive_relation, source: :follower
end
