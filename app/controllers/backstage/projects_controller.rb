class Backstage::ProjectsController < Backstage::BackstageController
  before_action :set_project, only: %i(show)
  def index
    @projects = Project.all.includes(:owner).order(created_at: :desc)
      .page(params[:page]).per(params[:per])
  end

  def show
  end

  private

  def set_project
    @project = Project.friendly.find(params[:id])
  end
end
