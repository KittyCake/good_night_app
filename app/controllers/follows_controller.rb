class FollowsController < ApplicationController
	before_action :set_follow, only: [:destroy_by_user_ids]

	# Users can follow other users.
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
	rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
	rescue => e
		Rails.logger.error e.message
		render json: e.message, status: :bad_request
	end

	# Users can unfollow other users.
	def destroy_by_user_ids
		@follow.destroy
		head :no_content
	rescue ActiveRecord::RecordNotFound => e
		puts 'not found'
    render json: { error: e.message }, status: :not_found
	rescue => e
		Rails.logger.error e.message
		render json: e.message, status: :bad_request
	end

	private

  def follow_params
    params.require(:follow).permit(:follower_id, :followed_user_id)
  end

	def set_follow
		puts "follow_params[:follower_id]: #{follow_params[:follower_id]}"
    @follow = Follow.find_by(follower_id: follow_params[:follower_id], followed_user_id: follow_params[:followed_user_id])
		puts "set: #{@follow.nil?}"
    raise ActiveRecord::RecordNotFound, 'Follow not found' if @follow.nil?
  end
end