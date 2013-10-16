class Backstage::LabsController < Backstage::BackstageController

  def index
    @labs = Lab.order(id: :desc)
  end

end
