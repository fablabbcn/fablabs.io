class StepsController < ApplicationController

  private
    def steps_params
      params.require(:step).permit(
        :id,
        :title,
        :description,
        :position,
        links_attributes: [ :id, :link_id, :url, '_destroy' ]
    end
end
