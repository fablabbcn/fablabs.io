class LabsController < ApplicationController

  before_filter :require_login, except: [:index, :map, :show]

  def map
    @labs = Lab.with_approved_state
  end

  def index
    all_labs = Lab.search(params[:q]).with_approved_state
    @countries = Lab.country_list_for all_labs
    @count = all_labs.size
    @labs = all_labs.in_country_code(params["country"])

    respond_to do |format|
      format.html
      format.json { render json: @labs }
    end
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
    @lab = Lab.friendly.find(params[:id])
    @nearby_labs = @lab.nearbys(500)
    authorize_action_for @lab
  end

  def destroy
    @lab = Lab.friendly.find(params[:id])
    authorize_action_for @lab
    @lab.delete
    redirect_to labs_path, notice: "Lab deleted"
  end

  def edit
    @lab = Lab.friendly.find(params[:id])
    authorize_action_for @lab
  end

  def update
    @lab = Lab.friendly.find(params[:id])
    authorize_action_for @lab
    if @lab.update_attributes lab_params
      redirect_to lab_url(@lab), notice: "Lab was successfully updated"
    else
      render :edit
    end
  end

private

  def lab_params
    params.require(:lab).permit!
  end

end
