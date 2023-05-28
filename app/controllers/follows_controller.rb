class FollowsController < ApplicationController
	before_action :set_follow, only: [:destroy_by_user_ids]

	# users can follow other users.
	def create
		follower = User.find(follow_params[:follower_id])
    followed_user = User.find(follow_params[:followed_user_id])

		@follow = Follow.new(
			follower: follower,
			followed_user: followed_user
		)

		if @follow.save
			render json: @follow, status: :created
		else
			render json: @follow.errors, status: :unprocessable_entity
		end
	end

	# users can unfollow other users.
	def destroy_by_user_ids
		@follow.destroy
		head :no_content
	end

	private

  def follow_params
    params.require(:follow).permit(:follower_id, :followed_user_id)
  end

	def set_follow
    @follow = Follow.find_by(follower_id: follow_params[:follower_id], followed_user_id: follow_params[:followed_user_id])
    raise ActiveRecord::RecordNotFound, 'Follow not found' if @follow.nil?
  end
end