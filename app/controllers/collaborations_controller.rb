class CollaborationsController < ApplicationController

  def destroy
    @collaboration = Collaboration.find(params[:id])
    @project = @collaboration.project
    authorize_action_for @project
    @collaboration.delete
    redirect_to project_path(@project), notice: "Contribution deleted"
  end

end
