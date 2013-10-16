class LabsController < ApplicationController

  before_filter :require_login, only: [:new, :create, :destroy]

  def index
    @labs = Lab.with_approved_state
  end

  def new
    @lab = current_user.created_labs.build
    authorize_action_for @lab
  end

  def create
    @lab = current_user.created_labs.build lab_params
    authorize_action_for @lab
    if @lab.save
      redirect_to labs_path, notice: "Thanks for adding your lab. We shall review your application and be in touch."
    else
      render :new
    end
  end

  def show
    @lab = Lab.find(params[:id])
    authorize_action_for @lab
  end

  def destroy
    @lab = Lab.find(params[:id])
    authorize_action_for @lab
    @lab.delete
    redirect_to labs_path, notice: "Lab deleted"
  end

private

  def lab_params
    params.require(:lab).permit!
  end

end
