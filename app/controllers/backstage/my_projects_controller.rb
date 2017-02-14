class Backstage::MyProjectsController < ApplicationController
  def index
    @q = current_user.created_projects.search(params[:q])

    @q.sorts = 'id desc' if @q.sorts.empty?
    @labs = @q.result.page(params[:page]).per(params[:per])
  end
end
