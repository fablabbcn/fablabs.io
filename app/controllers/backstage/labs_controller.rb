class Backstage::LabsController < Backstage::BackstageController
  include LabsOperations

  def index
    if current_user.has_role? :superadmin
      @q = Lab.includes(:creator).ransack(params[:q], auth_object: set_ransack_auth_object)
    elsif current_user.is_referee? or current_user.is_unique_referee?
      @q = Lab.includes(:creator).where("referee_id IN (?)",  current_user.admin_labs.map{ |u| u.resource_id }).ransack(params[:q], auth_object: set_ransack_auth_object)
    end

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

  alias edit_request_more_info edit

  def update
    @lab = Lab.friendly.find(params[:id])
    if @lab.update(lab_params)
      redirect_to backstage_labs_path, notice: "Lab updated"
    else
      render :edit
    end
  end

  %w( approve
      reject
      remove
      referee_approves
      referee_rejects
      referee_requests_admin_approval
      need_more_info
    ).each do |verb|
    define_method(verb) do
      verbed = action_to_verb[verb.parameterize.underscore.to_sym]
      @lab = Lab.friendly.find(params[:id])
      if @lab.send("#{verb}!", current_user)
        lab_send_action("#{verbed}")
        lab_log_workflow_action(verb)
        redirect_to backstage_labs_path, notice: "Lab #{verbed.tr('_', ' ')}"
      else
        redirect_to backstage_lab_path(@lab), notice: "Could not #{verb} lab"
      end
    end
  end

  def request_more_info
    @lab = Lab.friendly.find(params[:id])

    if @lab.update(lab_params)
      verbed = action_to_verb[action_name.parameterize.underscore.to_sym]

      if @lab.send("#{action_name}!", current_user)
        lab_send_action("#{verbed}")
        lab_log_workflow_action(action_name)
        redirect_to backstage_labs_path, notice: "Lab #{verbed.tr('_', ' ')}"
      end
    else
      render :edit_request_more_info
    end
  end

  private
    def lab_params
      params.require(:lab).permit!
    end

end
