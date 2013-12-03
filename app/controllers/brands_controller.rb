class BrandsController < ApplicationController
  def new
    @brand = Brand.new
    authorize_action_for @brand
  end

  def create
    @brand = Brand.new(brand_params)
    authorize_action_for @brand
    if @brand.save
      redirect_to new_machine_url, notice: "Brand Created"
    else
      render :new
    end
  end

private

  def brand_params
    params.require(:brand).permit(
      :name,
      :description
    )
  end
end
