class Backstage::OrganizationsController < Backstage::BackstageController

  def index
    @q = Organization.search(params[:q])
    @organizations = @q.result.page(params[:page])
  end
end
