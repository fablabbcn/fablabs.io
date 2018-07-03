class Api::V2::AdminController < Api::V2::ApiController
  before_action :doorkeeper_authorize! # Requires access token for all actions

  #TODO
  def create_user
    # Your code here
    error! :forbidden unless current_user.has_role? :superadmin
   
    render_json not_implemented
  end


  def list_users
    # Your code here
    error! :forbidden unless current_user.has_role? :superadmin
    @users,@paginate = paginate User.where("")
    options = {}
    options[:meta] = {'total-pages' => @paginate['pages'] }
    options[:links] = @paginate

    render_json  ApiUserSerializer.new(@users, options).serialized_json 
  end

  def search_users
    # Your code here
    error! :forbidden unless current_user.has_role? :superadmin
    @users,@paginate = paginate User.where("first_name LIKE ? or username LIKE ? or last_name LIKE ? or email LIKE ?", "%#{ params[:q].capitalize }%", "%#{ params[:q] }%", "%#{ params[:q].capitalize }%","%#{ params[:email] }%")
      # Your code here
    options = {}
    options[:meta] = {'total-pages' => @paginate['pages'] }
    options[:links] = @paginate
  
    render_json  ApiUserSerializer.new(@users, options).serialized_json 
  end


  def get_user
    error! :forbidden unless current_user.has_role? :superadmin
    options = {}
    @user = User.friendly.where("username = ?", params[:username]).first
    render_json  ApiUserSerializer.new(@user, options).serialized_json
  end


end
