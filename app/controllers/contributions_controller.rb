class ContributionsController < ApplicationController

  def destroy
    @contribution = Contribution.find(params[:id])
    @project = @contribution.project
    authorize_action_for @project
    @contribution.delete
    redirect_to project_path(@project), notice: "Contribution deleted"
  end

end
