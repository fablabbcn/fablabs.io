class Api::LegacyController < ActionController::API
  def index
    render json: { error: "This endpoint does not exist anymore" }, status: :not_found
  end
end