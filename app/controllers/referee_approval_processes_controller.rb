class RefereeApprovalProcessesController < ApplicationController
  def destroy
    @referee_approval = RefereeApprovalProcess.find(params[:id])
    @lab = @referee_approval.referred_lab
    if authorize_action_for @lab
      @referee_approval.delete
      redirect_to lab_path(@lab), notice: "Approval Process Deleted"
    else
      redirect_to lab_path(@lab), notice: "You cannot delete this approval process"
    end
  end
end
