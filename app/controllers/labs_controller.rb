class LabsController < ApplicationController

  before_filter :require_login, only: [:new, :create, :destroy]

  def index
    @labs = Lab.all
  end

  def new
    @lab = Lab.new
  end

  def create
    @lab = Lab.new lab_params
    if @lab.save
      redirect_to labs_path, notice: "Thanks for adding your lab. We shall review your application and be in touch."
    else
      render :new
    end
  end

  def show
    @lab = Lab.find(params[:id])
  end

  def destroy
    @lab = Lab.find(params[:id])
    @lab.delete
    redirect_to labs_path, notice: "Lab deleted"
  end

private

  def lab_params
    params.require(:lab).permit!
  end

end
