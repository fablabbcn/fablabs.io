class Backstage::LabsController < Backstage::BackstageController

  def index
    @q = Lab.search(params[:q])
    @q.workflow_state_eq = 'unverified' unless params[:q]
    @q.sorts = 'id desc' if @q.sorts.empty?
    @labs = @q.result.page(params[:page]).per(params[:per])
    #(distinct: true)
    # @labs = Lab.order(id: :desc)
  end

  def show
    @lab = Lab.friendly.find(params[:id])
  end

  %w(approve reject).each do |verb|
    define_method(verb) do
      @lab = Lab.friendly.find(params[:id])
      if @lab.send("#{verb}!")
        redirect_to backstage_labs_path, notice: "Lab #{verb}ed".gsub('ee', 'e')
      else
        redirect_to backstage_lab_path(@lab), notice: "Could not #{verb} lab"
      end
    end
  end

end
