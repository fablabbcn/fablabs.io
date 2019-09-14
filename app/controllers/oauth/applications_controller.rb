
class Oauth::ApplicationsController < Doorkeeper::ApplicationsController

  before_action :require_login

  def index
    @applications = current_user.oauth_applications
  end


  def show
     @token =  Doorkeeper::AccessToken.find_or_create_by(:application_id => @application.id, :resource_owner_id => current_user.id)
    if @token.revoked? || @token.expired? then
        @token =  Doorkeeper::AccessToken.create(:application_id => @application.id, :resource_owner_id => current_user.id)
    end
    super
  end

  # only needed if each application must have some owner
  def create
    @application = Doorkeeper::Application.new(application_params)
    @application.owner = current_user # if Doorkeeper.configuration.confirm_application_owner?
    if @application.save
      flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :create])
      redirect_to oauth_application_url(@application)
    else
      render :new
    end
  end

  private

  def set_application
    @application = current_user.oauth_applications.find(params[:id])
  end

end
