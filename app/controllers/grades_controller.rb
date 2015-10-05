class GradesController < ApplicationController
  def create
    current_user.grades.create(project_id: params[:project_id], stars: params[:stars])
    redirect_to project_path(params[:project_id])
  end

  def destroy
    @grade = current_user.grades.find(params[:id])
    @grade.destroy
    redirect_to project_path(params[:project_id])
  end
end
