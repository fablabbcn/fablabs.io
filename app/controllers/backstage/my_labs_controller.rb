class Backstage::MyLabsController < Backstage::BackstageController
  skip_before_action :require_admin, only: :index

  def index
    @q = current_user.created_labs.ransack(params[:q], auth_object: set_ransack_auth_object)

    @q.sorts = 'id desc' if @q.sorts.empty?
    @labs = @q.result.page(params[:page]).per(params[:per])
  end
end
