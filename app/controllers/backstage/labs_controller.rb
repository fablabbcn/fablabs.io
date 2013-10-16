class Backstage::LabsController < Backstage::BackstageController

  def index
    @labs = Lab.order(id: :desc)
  end

  def show
    @lab = Lab.friendly.find(params[:id])
  end

  def approve
    @lab = Lab.friendly.find(params[:id])
    if @lab.approve!
      redirect_to backstage_labs_path, notice: 'Lab approved'
    else
      redirect_to backstage_lab_path(@lab), notice: 'Lab could not be approved'
    end
  end

end
