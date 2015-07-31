class Backstage::UsersController < Backstage::BackstageController
  before_filter :require_admin
  
  def index
    @q = User.search(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @users = @q.result
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes user_params
      redirect_to backstage_users_path, notice: "User updated"
    else
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit!
  end


  def require_admin
    if current_user
      unless current_user.has_role? :superadmin
        return redirect_to backstage_labs_url, notice: "Not authorized"
      end
    else
      return redirect_to signin_url
    end
  end

end
