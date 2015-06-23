class CollaborationsController < ApplicationController

  def destroy
    @collaboration = Collaboration.find(params[:id])
    @project = @collaboration.project
    if authorize_action_for @project
      @collaboration.delete
      redirect_to project_path(@project), notice: "Collaboration deleted"
    else
      redirect_to project_path(@project), notice: "You cannot delete this collaboration"
    end
  end

end
