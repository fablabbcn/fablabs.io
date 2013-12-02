class Backstage::UsersController < Backstage::BackstageController

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

end
