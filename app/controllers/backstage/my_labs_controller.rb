class Backstage::MyLabsController < Backstage::BackstageController
  def index
    @q = current_user.created_labs.ransack(params[:q], auth_object: set_ransack_auth_object)

    @q.sorts = 'id desc' if @q.sorts.empty?
    @labs = @q.result.page(params[:page]).per(params[:per])
  end
end
