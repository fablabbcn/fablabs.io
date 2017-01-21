class Backstage::ToApproveLabsController < ApplicationController

  def index
    @q = Lab.where(id: current_user.referee_labs.map(&:id)).search(params[:q])

    @q.sorts = 'id desc' if @q.sorts.empty?
    @labs = @q.result.page(params[:page]).per(params[:per])
  end
end
