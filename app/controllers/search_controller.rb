class SearchController < ApplicationController

  before_filter :require_login, except: :index

  def index
    @results = Lab.where("slug LIKE ? or name LIKE ?", "%#{params[:q]}%", "%#{params[:q].capitalize}%")
    @results << Project.where("title LIKE ?", "%#{params[:q]}%")

    render :locals => { @results, each_serializer: SearchResultSerializer } 

  end
