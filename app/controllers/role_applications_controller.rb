class RoleApplicationsController < ApplicationController

  def new
    @lab = Lab.friendly.find(params[:lab_id])
    @role_application = @lab.role_applications.build
    authorize_action_for @role_application
  end

  def create
    @lab = Lab.friendly.find(params[:lab_id])
    @role_application = @lab.role_applications.build role_application_params
    @role_application.user = current_user
    authorize_action_for @role_application
    if @role_application.save
      redirect_to lab_path(@lab), notice: "You have applied"
    else
      render :new
    end
  end

private

  def role_application_params
    params.require(:role_application).permit(
      :lab_id,
      :description
    )
  end

end
