class SearchController < ApplicationController
  include LabsSearch
  include ProjectsOperations
  include UsersOperations

  before_filter :require_login, except: :index

  def index
    @labs = search_labs(params[:q]).page(1).per(25)
    @projects = search_projects(params[:q]).page(1).per(25)
    @users = search_users(params[:q]).page(1).per(25)

    respond_to do |format|
      format.html
    end
  end

end
