class SearchController < ApplicationController

  before_filter :require_login, except: :index

  @results = Lab.where("slug LIKE ? or name LIKE ?", "%#{params[:q]}%", "%#{params[:q].capitalize}%")
  @results << Project.where("title LIKE ?", "%#{params[:q]}%")

  def index
    respond_to do |format|
      format.html { render :locals => { @results, each_serializer: SearchResultSerializer } }
    end
  end
