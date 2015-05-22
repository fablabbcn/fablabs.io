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
    @project = Project.new(owner: current_user)
    authorize_action_for @project
  end

  def create
    @project = Project.create(owner: current_user)
    authorize_action_for @project
    if @project.save
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


end
