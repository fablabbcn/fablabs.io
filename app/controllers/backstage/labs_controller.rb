class Backstage::LabsController < Backstage::BackstageController

  def index
    @labs = Lab.order(id: :desc)
  end

  def show
    @lab = Lab.find(params[:id])
  end

end
