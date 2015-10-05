class SearchController < ApplicationController

  before_filter :require_login, except: :index

  def index
    @labs = Lab.where("slug LIKE ? or name LIKE ?", "%#{params[:q]}%", "%#{params[:q].capitalize}%").page(params['page']).per(params['per'])
    @projects = Project.where("title LIKE ?", "%#{params[:q]}%").page(params['page']).per(params['per'])

    respond_to do |format|
      format.html
    end
  end

end
