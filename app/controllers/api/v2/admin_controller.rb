# frozen_string_literal: true

# AdminController
# admin-only api for system-level integrations
class Api::V2::AdminController < Api::V2::ApiController
  before_action :doorkeeper_authorize! # Requires access token for all actions

  # create a verified user, sending the welcome email
  def create_user
    error! :forbidden unless current_user.has_role? :superadmin

    param_dict = JSON.parse(request.body.read)
    params = ActionController::Parameters.new(param_dict)

    @user = User.new user_params
    begin
      @user.save!
      @user.verify!
    rescue ActiveRecord::RecordInvalid => ex
      logger.error 'ActiveRecord::RecordInvalid'
      logger.error ex.message
      error! :bad_request
    end
    UserMailer.welcome(@user.id).deliver_now
    render_json ApiUserSerializer.new(@user, {}).serialized_json
  end

  def list_users
    # Your code here
    error! :forbidden unless current_user.has_role? :superadmin
    @users, @paginate = paginate User.where('')
    options = {}
    options[:meta] = { 'total-pages' => @paginate[:pages] }
    options[:links] = @paginate

    render_json ApiUserSerializer.new(@users, options).serialized_json
  end

  def search_users
    # Your code here
    error! :forbidden unless current_user.has_role? :superadmin
    params[:username] ||= ''
    params[:email] ||= ''

    @users, @paginate = User.where(
      'username LIKE ? or email LIKE ?',
      "%#{params[:username]}%",
      "%#{params[:email]}%"
    )

    # Your code here
    options = {}
    options[:meta] = { 'total-pages' => @paginate[:pages] }
    options[:links] = @paginate

    render_json ApiUserSerializer.new(@users, options).serialized_json
  end

  def get_user
    error! :forbidden unless current_user.has_role? :superadmin
    options = {}
    @user = User.where('username = ? ', params[:username]).first
    render_json ApiUserSerializer.new(@user, options).serialized_json
  end

  private

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
      links_attributes: [:id, :link_id, :url, '_destroy']
    )
  end
end
