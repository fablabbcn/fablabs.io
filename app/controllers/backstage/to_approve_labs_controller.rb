class Backstage::ToApproveLabsController < ApplicationController

  before_action :require_login
  def index
    @q = Lab.where(id: current_user.referee_labs.map(&:id)).ransack(params[:q])

    @q.sorts = 'id desc' if @q.sorts.empty?
    @labs = @q.result.page(params[:page]).per(params[:per])
  end
end
