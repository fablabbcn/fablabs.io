class ProjectsController < ApplicationController
  include ProjectsOperations

  before_filter :require_login, except: [:index, :show, :search]

  def index
    @projects = all_projects.page(params['page']).per(params['per'])

    respond_to do |format|
      format.html
      format.json { render json: @projects }
      # format.csv { send_data @projects.to_csv }
    end
  end

  def search
    @projects = filter_by(params).page(params['page']).per(params['per'])
    respond_to do |format|
      format.html { render template: 'projects/index'}
      format.json { render json: @projects }
      # format.csv { send_data @projects.to_csv }
    end
  end

  def show
    @project = Project.find(params[:id])
    authorize_action_for @project
  end

  def new
    @project = current_user.created_projects.build
    @project.contributions.build
    @project.collaborations.build
    authorize_action_for @project
  end

  def create
    @project = current_user.created_projects.build project_params
    @project.assign_attributes(owner: current_user)
    authorize_action_for @project
    if @project.save
      track_activity @project
      redirect_to projects_path, notice: "Thanks for adding your project."
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    authorize_action_for @project
  end

  def update
    @project = Project.find(params[:id])
    authorize_action_for @project
    if @project.update_attributes project_params
      track_activity @project
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

  def map
    @projects = Project.all
  end

  def mapdata
    @projects = map_projects
    render json: @projects
  end

  private
    def project_params
      attributes = [
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
        :instagram,
        :drive,
        :youtube,
        :vimeo,
        :googleplus,
        :cover,
        :twitter,
        :facebook,
        tag_list: [],
        documents_attributes: [ :id, :image, :photo, :title, :description ],
        steps_attributes: [
          :id,
          :title,
          :description,
          :position,
          '_destroy',
          links_attributes: [:id, :link_id, :url, '_destroy'] ],
        contributions_attributes: [ :id, :contributor_id ],
        collaborations_attributes: [ :id, :collaborator_id ],
        links_attributes: [ :id, :link_id, :url, '_destroy' ],
        machineries_attributes: [ :id, :device_id ]
      ]

      attributes.push(links_attributes)
      params.require(:project).permit(attributes)
    end
end
