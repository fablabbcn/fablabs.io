class AdminsController < ApplicationController

  before_filter :require_login

  # authorize_actions_for :parent_resource, all_actions: :update

  def index
    @lab = Lab.friendly.find(params[:lab_id])
    @admins = (User.with_role(:admin) + [current_user]).uniq
    @lab_admins = (User.with_role(:admin, @lab) - @admins).uniq
    @potential_lab_admins = (User.all - @admins - @lab_admins).uniq
  end

  def new
    @lab = Lab.friendly.find(params[:lab_id])
  end

  def create
    @lab = Lab.friendly.find(params[:lab_id])
    user = User.find(params[:user_id])
    if role = user.add_role(:admin, @lab)
      UserMailer.role_added(role, user).deliver
      redirect_to lab_admins_path(@lab), notice: "Admin added"
    else
      redirect_to lab_admins_path(@lab), notice: "Admin could not be added"
    end
  end

  def destroy
    @lab = Lab.friendly.find(params[:lab_id])
    user = User.find(params[:user_id])
    if role = user.remove_role(:admin, @lab)
      # UserMailer.role_added(role, user).deliver
      redirect_to lab_admins_path(@lab), notice: "Admin removed"
    else
      redirect_to lab_admins_path(@lab), notice: "Admin could not be removed"
    end
  end

private

  def parent_resource
    Lab.friendly.find(params[:lab_id])
  end

end
