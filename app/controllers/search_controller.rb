class SearchController < ApplicationController
  include LabsSearch
  include ProjectsOperations
  include UsersOperations

  before_action :require_login, except: :index

  def index
    @labs = search_labs(params[:query]).page(params['page']).per(params['per'] || 10)
    #@projects = search_projects(params[:query])
    @results = @labs # + @projects
    respond_to do |format|
      format.html
    end
  end

end
