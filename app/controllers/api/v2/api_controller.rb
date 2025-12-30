class Api::V2::ApiController < ActionController::API
  include ActionController::Head
  include Doorkeeper::Rails::Helpers

  before_action :doorkeeper_authorize!

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

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
    pagination[:prev] = current - 1 if current > 1
    pagination[:next] = current + 1 if current != total

    [collection, pagination]
  end

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def current_user
    @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def not_implemented
    {
      errors: [
        {
          status: "500",
          title: "Not implemented",
          detail: "Apologies, this method is not yet implemented"
        }
      ]
    }
  end

  def render_not_found
    render json: { errors: [{ status: "404", title: "Not Found" }] }, status: :not_found
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
