class Backstage::ProjectsController < Backstage::BackstageController
  before_action :set_project, only: %i(show edit update destroy)

  def index
    @projects = Project.all.includes(:owner).order(created_at: :desc)
      .page(params[:page]).per(params[:per])
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to backstage_project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project.destroy

    redirect_to backstage_projects_path
  end

  private

  def set_project
    @project = Project.friendly.find(params[:id])
  end

  def project_params
    params.require(:project).permit!
  end
end
