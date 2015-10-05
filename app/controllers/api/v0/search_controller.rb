class Api::V0::SearchController < Api::V0::ApiController
  def all

    @results = Lab.where("slug LIKE ? or name LIKE ?", "%#{params[:q]}%", "%#{params[:q].capitalize}%")
    @results << Project.where("title LIKE ?", "%#{params[:q]}%", "%#{params[:q].capitalize}%")
    render json: @results, each_serializer: SearchResultSerializer
  end

  def labs
    @labs = Lab.where("slug LIKE ? or name LIKE ?", "%#{params[:q]}%", "%#{params[:q].capitalize}%")
    render json: @labs, each_serializer: LabSerializer
  end

  def projects
    @labs = Project.where("title LIKE ?", "%#{params[:q]}%", "%#{params[:q].capitalize}%")
    render json: @labs, each_serializer: LabSerializer
  end

end
