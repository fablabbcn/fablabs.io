class DiscussionsController < ApplicationController
  def index
    @discussions = Lab.friendly.find(params[:lab_id]).discussions
  end
end
