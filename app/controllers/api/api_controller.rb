class Api::ApiController < ActionController::API
  include ActionController::Head
  include Doorkeeper::Rails::Helpers

  respond_to :json
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def paginate(scope, default_per_page = 10)
    collection = scope.page(params[:page]).per((params[:per_page] || default_per_page).to_i)

    current, total, per_page = collection.current_page, collection.total_pages, collection.limit_value

    pagination = {
      self:     current,
      per_page: per_page,
      pages:    total,
      count:    collection.total_count
    }
    if current > 1 then
      pagination[:prev] =  current - 1
    end
    if current != total then
      pagination[:next] =  current + 1
    end
    
    return [
      collection,
      pagination
    ]
  end

  def record_not_found error
    render json: { error: error.message }, status: :not_found
  end

  def current_user
    if doorkeeper_token
      @current_user ||= User.find(doorkeeper_token.resource_owner_id)
    end
  end

  def doorkeeper_unauthorized_render_options(error: nil)
    {
      json: {
        errors: [
          {
            status: "401",
            title: "Unauthorized",
            detail: error&.description || "Access token is missing or invalid"
          }
        ]
      }
    }
  end

end
