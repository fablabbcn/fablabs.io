class Api::V1::LabsController < Api::V1::ApiController

  caches :index, caches_for: 10.minutes

  def index
    expose Lab.with_approved_state.includes(:links)
  end

end
