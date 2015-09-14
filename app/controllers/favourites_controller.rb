class FavouritesController < ApplicationController
  def create
    current_user.favourites.create(project_id: params[:project_id])
    redirect_to project_path(params[:project_id])
  end

  def destroy
    @fav = current_user.favourites.where(project_id: params[:project_id]).first
    @fav.destroy
    redirect_to project_path(params[:project_id])
  end
end
