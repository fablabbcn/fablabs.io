class AdminApplicationsController < ApplicationController
  def new
    @lab = Lab.friendly.find(params[:lab_id])
    @admin_application = @lab.admin_applications.build
  end

  def create
    @lab = Lab.friendly.find(params[:lab_id])
    @admin_application = @lab.admin_applications.new params[:admin_application]
    @admin_application.applicant = current_user
  end
end
