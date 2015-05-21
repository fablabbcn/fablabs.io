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
  end

  def create
  end

  def edit
    @project = Project.find(params[:id])
    authorize_action_for @project
  end


end
