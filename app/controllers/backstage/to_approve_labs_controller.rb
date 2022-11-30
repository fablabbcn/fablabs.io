class Backstage::ToApproveLabsController < Backstage::BackstageController
  before_action :require_login

  def index
    @q = Lab.where(id: current_user.referee_labs.map(&:id)).ransack(params[:q], auth_object: set_ransack_auth_object)

    @q.sorts = 'id desc' if @q.sorts.empty?
    @labs = @q.result.page(params[:page]).per(params[:per])
  end
end
