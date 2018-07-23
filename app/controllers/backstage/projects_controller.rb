class Backstage::ProjectsController < Backstage::BackstageController
  def index
    @projects = Project.all.includes(:owner).order(created_at: :desc)
      .page(params[:page]).per(params[:per])
  end
end
