class ProjectsController < ApplicationController

  before_filter :require_login, except: [:index, :map, :show, :mapdata, :embed]

  def index
    @projects = Project.includes(:owner, :lab, :contributors).page(params['page']).per(params['per'])

    respond_to do |format|
      format.html
      format.json { render json: @projects }
      # format.csv { send_data @labs.to_csv }
    end
  end

  def show
    @project = Project.find(params[:id])
    authorize_action_for @project
  end

  def new
    @user_options = User.limit(10).map{ |u| [ u.username, u.id ] }
    @project = current_user.created_projects.build
    @project.contributions.build
    authorize_action_for @project
  end

  def create
    @project = current_user.created_projects.build project_params
    @project.assign_attributes(owner: current_user)
    authorize_action_for @project
    if @project.save
      redirect_to projects_path, notice: "Thanks for adding your project."
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    @user_options = User.limit(10).map{ |u| [ u.username, u.id ] }
    authorize_action_for @project
  end

  def update
    @project = Project.find(params[:id])
    authorize_action_for @project
    if @project.update_attributes project_params
      redirect_to project_url(@project), notice: "Project was successfully updated"
    else
      render :edit
    end

  end

  def destroy
    @project = Project.find(params[:id])
    authorize_action_for @project
    @project.delete
    redirect_to projects_path, notice: "Project deleted"
  end

  private
    def project_params
      params.require(:project).permit(
        :type,
        :title,
        :description,
        :github,
        :bitbucket,
        :dropbox,
        :web,
        :description,
        :scope,
        :faq,
        :lookingfor,
        :community,
        :lab_id,
        :owner_id,
        :flickr,
        :drive,
        :youtube,
        :vimeo,
        :googleplus,
        contributions_attributes: [ :contributor_id ],
        collaborations_attributes: [ :collaborator_id ],
        machineries_attributes: [ :device_id ])
    end


end
