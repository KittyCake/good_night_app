class Follow < ApplicationRecord
    belongs_to :follower, class_name: 'User'
    belongs_to :followed_user, class_name: 'User'

    validates :follower, presence: true
    validates :followed_user, presence: true
end
