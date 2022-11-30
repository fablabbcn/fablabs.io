class Backstage::LabsManagerController < Backstage::BackstageController
  before_action :require_superadmin
  include LabsSearch
  
  def index
    @p = Lab.includes(:creator).ransack(params[:q], auth_object: set_ransack_auth_object)
    # @labs = search_labs_admin(name).page(params['page']).per(params['per'] || 10)
    @labs = @p.result.page(params['page']).per(params['per'] || 100)
    @sql = @p.result.to_sql
  end

  def show
    @lab = Lab.friendly.find(params[:id])
  end


end
