class User < ApplicationRecord
    validates :name, presence: true

    has_many :sleep_records, dependent: :destroy
    has_many :followings, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
    has_many :followers, class_name: 'Follow', foreign_key: 'followed_user_id', dependent: :destroy
    has_many :followed_users, through: :followings, source: :followed_user
    has_many :follower_users, through: :followers, source: :follower
end
