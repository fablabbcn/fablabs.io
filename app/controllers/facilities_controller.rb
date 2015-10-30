class FacilitiesController < ApplicationController

  def destroy
    @facility = Facility.find(params[:id])
    @lab = @facility.lab
    @machine = @facility.thing
    if authorize_action_for @lab
      @facility.delete
      redirect_to machine_path(@machine), notice: "Facility deleted"
    else
      redirect_to machine_path(@machine), notice: "You cannot delete this facility"
    end
  end

end
