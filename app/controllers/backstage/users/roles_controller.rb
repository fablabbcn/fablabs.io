class Backstage::Users::RolesController < Backstage::BackstageController
  before_action :find_user

  def index
    @roles = @user.roles
  end

  def new
    @role = @user.roles.build
  end

  def create
    @user.add_role(params[:role][:name])
    redirect_to [:backstage, @user, :roles], notice: 'Role created'
  end

  def destroy
    @role = @user.roles.find(params[:id])
    @role.destroy
    redirect_to [:backstage, @user, :roles], notice: 'Role destroyed'
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
