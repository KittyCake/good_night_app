class SleepRecordsController < ApplicationController
	# return all clocked-in times, ordered by created time.
	def index
		sleep_records = SleepRecord.order(:created_at)
    render json: sleep_records, status: :ok
	end

	# clock in operation
	def create
		validate_user_existence
		@sleep_record = SleepRecord.new(sleep_record_params)

		if @sleep_record.save
			render json: @sleep_record, status: :created
		else
			render json: @sleep_record.errors, status: :unprocessable_entity
		end
	end

	# see the sleep records of a user’s all following users' sleep records.
	# from the previous week, which are sorted based on the duration of all friends
	def followings_records
		user = User.includes(:followed_users).find_by!(id: sleep_record_params[:user_id])
		followed_users_ids = user.followed_users.map(&:id)

		sleep_records_sorted = SleepRecord.where(user_id: followed_users_ids)
																			.where('created_at >= ?', 1.week.ago)
																			.sort_by { |record| -record.duration }

		render json: sleep_records_sorted, status: :ok
	end

	private

  def sleep_record_params
    params.require(:sleep_record).permit(:started_at, :ended_at, :user_id)
  end

	def validate_user_existence
		User.find_by!(id: sleep_record_params[:user_id])
	end
end

