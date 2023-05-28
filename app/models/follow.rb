class Follow < ApplicationRecord
    belongs_to :follower, class_name: 'User'
    belongs_to :followed_user, class_name: 'User'

    validates :follower, :followed_user, presence: true
end
