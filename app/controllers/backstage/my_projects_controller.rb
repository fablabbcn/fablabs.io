class Backstage::MyProjectsController < ApplicationController
  def index
    @q = current_user.created_projects.ransack(params[:q])

    @q.sorts = 'id desc' if @q.sorts.empty?
    @projects = @q.result.page(params[:page]).per(params[:per])
  end
end
