class SearchController < ApplicationController
  include LabsSearch
  include ProjectsOperations
  include UsersOperations

  before_filter :require_login, except: :index

  def index
    @labs = search_labs(params[:q])
    @projects = search_projects(params[:q])
    
    @results = @labs + @projects   
    
    respond_to do |format|
      format.html
    end
  end

end
