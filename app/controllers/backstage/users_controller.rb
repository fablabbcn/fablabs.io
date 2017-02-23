class Backstage::UsersController < Backstage::BackstageController
  before_filter :require_admin

  def index
    @q = User.search(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @users = @q.result.page(params[:page])
  end

  def show
    @user = User.friendly.find(params[:id])
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    @user = User.friendly.find(params[:id])
    if @user.update_attributes user_params
      redirect_to backstage_users_path, notice: "User updated"
    else
      render :edit
    end
  end

  def list
    @users = User.all.map { |e| "#{e.full_name} - #{e.email}" }
    render text: @users.to_csv
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
