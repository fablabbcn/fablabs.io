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
      verbed = "#{verb}ed".gsub('ee', 'e')
      @lab = Lab.friendly.find(params[:id])
      if @lab.send("#{verb}!")
        UserMailer.send("lab_#{verbed}", @lab).deliver
        redirect_to backstage_labs_path, notice: "Lab #{verbed}"
      else
        redirect_to backstage_lab_path(@lab), notice: "Could not #{verb} lab"
      end
    end
  end

end
