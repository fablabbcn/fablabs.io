class Backstage::LabsController < Backstage::BackstageController

  def index
    if current_user.has_role? :superadmin
      @q = Lab.includes(:creator).search(params[:q])
    elsif current_user.is_referee?
      @q = Lab.includes(:creator).where("referee_id IN (?)",  current_user.admin_labs.map{ |u| u.resource_id }).search(params[:q])
    end
    @q.workflow_state_eq = 'unverified' unless params[:q]
    @q.sorts = 'id desc' if @q.sorts.empty?
    @labs = @q.result.page(params[:page]).per(params[:per])
    #(distinct: true)
    # @labs = Lab.order(id: :desc)
  end

  def show
    @lab = Lab.friendly.find(params[:id])
  end

  def edit
    @lab = Lab.friendly.find(params[:id])
  end

  def update
    @lab = Lab.friendly.find(params[:id])
    if @lab.update_attributes lab_params
      redirect_to backstage_labs_path, notice: "Lab updated"
    else
      render :edit
    end
  end

  %w(approve reject remove referee_approve more_info_needed).each do |verb|
    define_method(verb) do
      verbed = "#{verb}ed".gsub('ee', 'e')
      @lab = Lab.friendly.find(params[:id])
      if @lab.send("#{verb}!")
        UserMailer.delay.send("lab_#{verbed}", @lab.id)
        redirect_to backstage_labs_path, notice: "Lab #{verbed}"
      else
        redirect_to backstage_lab_path(@lab), notice: "Could not #{verb} lab"
      end
    end
  end

private

  def lab_params
    params.require(:lab).permit!
  end

end
