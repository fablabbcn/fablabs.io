class Backstage::ProjectsController < ApplicationController
  def index
    @projects = Project.all.includes(:owner, :lab).order(title: :asc)
      .page(params[:page]).per(params[:per])
  end

  def visibility
    @project = Project.find(params[:project_id])

    @project.visibility = action_name
    @project.save!

    redirect_to backstage_projects_path
  end

  alias visible visibility
  alias hidden  visibility
end
