class Api::V1::ApiController < ApplicationController
  respond_to :json
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def doorkeeper_unauthorized_render_options
    { json: { error: "Not authorized" }}
  end

private

  def record_not_found error
    render json: { error: error.message }, status: :not_found
  end

  def current_user
    if doorkeeper_token
      @current_user ||= User.find(doorkeeper_token.resource_owner_id)
    end
  end

  helper_method :current_or_null_user
  def current_or_null_user
    current_user || User.new
    # if current_user == nil
    #   User.new
    # else
    #   current_user
    # end
  end
end
