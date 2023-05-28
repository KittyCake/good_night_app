class Follow < ApplicationRecord
	belongs_to :follower, class_name: 'User'
	belongs_to :followed_user, class_name: 'User'

	validates :follower, :followed_user, presence: true
	validate :cannot_follow_self

	private

	def cannot_follow_self
		if follower == followed_user
			errors.add(:base, 'User cannot follow themselves')
		end
	end
end
