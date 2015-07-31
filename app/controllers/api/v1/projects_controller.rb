class Api::V1::ProjectsController < Api::V1::ApiController

  caches :index, caches_for: 10.minutes

  def index
    expose Project.all
  end

end
