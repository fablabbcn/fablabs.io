class RedirectsController < ApplicationController
  def show
    if @lab = Lab.friendly.find(params[:id]) rescue nil
      redirect_to lab_path(@lab), status: 302
    else
      raise ActionController::RoutingError.new("Path not found")
    end
  end
end
