class ApplicationController < ActionController::API
  rescue_from StandardError, with: :standard_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(e)
    Rails.logger.error e.message
    render json: { error: e.message }, status: :not_found
  end

  def standard_error(e)
    Rails.logger.error e.message
    render json: { error: e.message }, status: :bad_request
  end
end
