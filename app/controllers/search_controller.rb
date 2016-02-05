class SearchController < ApplicationController
  include LabsSearch
  include ProjectsOperations
  include UsersOperations

  before_filter :require_login, except: :index

  def index
    @labs = search_labs(params[:q])
    @projects = search_projects(params[:q])
    @users = search_users(params[:q])

    @results = @labs + @projects + @users

    respond_to do |format|
      format.html
    end
  end

end
