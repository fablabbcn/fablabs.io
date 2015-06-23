class ContributionsController < ApplicationController

  def destroy
    @contribution = Contribution.find(params[:id])
    @project = @contribution.project
    if authorize_action_for @project
      @contribution.delete
      redirect_to project_path(@project), notice: "Contribution deleted"
    else
      redirect_to project_path(@project), notice: "You cannot delete this contribution"
    end
  end

end
