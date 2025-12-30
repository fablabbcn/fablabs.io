# frozen_string_literal: true

class Api::V2::AdminController < Api::V2::ApiController
  before_action :doorkeeper_authorize! # Requires access token for all actions
  before_action :authorize_superadmin!

  def create_user
    logger.info 'Creating user through API v2'

    param_dict = JSON.parse(request.body.read)
    params = ActionController::Parameters.new(param_dict)

    @user = User.new(user_params)

    begin
      @user.save!
      @user.verify!
    rescue ActiveRecord::RecordInvalid => ex
      logger.error ex.message
      return render json: { error: 'Invalid user data' }, status: :bad_request
    end

    render json: ApiUserSerializer.new(@user).serializable_hash
  end

  def list_users
    @users, @paginate = paginate(User.all)

    render json: ApiUserSerializer.new(@users, pagination_options(@paginate)).serializable_hash
  end

  def search_users
    data = params.require(:data).permit(:username, :email)

    query = User.all
    query = query.where('UPPER(username) = UPPER(?)', data[:username]) if data[:username].present?
    query = query.where('UPPER(email) = UPPER(?)', data[:email]) if data[:email].present?

    @users, @paginate = paginate(query)

    render json: ApiUserSerializer.new(@users, pagination_options(@paginate)).serializable_hash
  end

  def get_user
    @user = User.friendly.find(params[:slug])
    render json: ApiUserSerializer.new(@user).serializable_hash
  end

  private

  def authorize_superadmin!
    return if current_user&.has_role?(:superadmin)

    render json: { error: 'Forbidden' }, status: :forbidden
  end

  def user_params
    params.require(:data).permit(
      :agree_policy_terms,
      :username,
      :first_name,
      :last_name,
      :email,
      :email_fallback,
      :phone,
      :password,
      :password_confirmation,
      :country_code,
      :avatar,
      :use_metric,
      :bio,
      :url,
      links_attributes: %i[id link_id url _destroy]
    )
  end

  def pagination_options(paginate)
    {
      meta: { 'total-pages' => paginate[:pages] },
      links: paginate
    }
  end
end
