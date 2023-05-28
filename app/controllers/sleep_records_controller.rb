class SleepRecordsController < ApplicationController
	# return all clocked-in times, ordered by created time.
	def index
		sleep_records = SleepRecord.order(:created_at)
    render json: sleep_records, status: :ok
	rescue => e
		Rails.logger.error e.message
		render json: e.message, status: :bad_request
	end

	# Clock In operation
	def create
		@sleep_record = SleepRecord.new(sleep_record_params)

		if @sleep_record.save
			render json: @sleep_record, status: :created
		else
			render json: @sleep_record.errors, status: :unprocessable_entity
		end
	rescue => e
		Rails.logger.error e.message
		render json: e.message, status: :bad_request
	end

	# See the sleep records of a user’s All following users' sleep records.
	# from the previous week, which are sorted based on the duration of All friends
	def followings_records
		user = User.includes(:followed_users).find_by!(id: sleep_record_params[:user_id])
		followed_users_ids = user.followed_users.map(&:id)

		sleep_records_sorted = SleepRecord.where(user_id: followed_users_ids)
																			.where('created_at >= ?', 1.week.ago)
																			.sort_by { |record| -record.duration }

		render json: sleep_records_sorted, status: :ok
	rescue => e
		Rails.logger.error e.message
		render json: e.message, status: :bad_request
	end

	private

  def sleep_record_params
    params.require(:sleep_record).permit(:started_at, :ended_at, :user_id)
  end
end

