class Api::V0::SearchController < Api::V0::ApiController
  include LabsSearch
  include ProjectsOperations

  def all
    @results = search_labs(params[:q]).page(params['page']).per(params['per']) |  search_projects(params[:q]).page(params['page']).per(params['per'])

    respond_to do |format|
      format.json { render json: @results, each_serializer: SearchResultSerializer }
      # format.csv { send_data @results.to_csv }
    end

  end

  def labs
    @labs = search_labs(params[:q]).page(params['page']).per(params['per'])
    render json: @labs, each_serializer: LabSerializer
  end

  def projects
    @projects = search_projects(params[:q]).page(params['page']).per(params['per'])
    render json: @projects
  end

end
