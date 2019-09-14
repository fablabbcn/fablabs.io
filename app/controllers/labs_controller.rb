# frozen_string_literal: true

class LabsController < ApplicationController
  include LabsOperations

  before_action :require_login, except: [:index, :map, :show, :mapdata, :embed, :list]
  after_action :allow_iframe, only: [:embed, :list]

  before_action :require_login, except: %i[index map show mapdata embed list]
  after_action :allow_iframe, only: %i[embed list]

  # authorize_actions_for Lab, actions: { map: :read, manage_admins: :update}

  def embed
    @labs = Lab.with_approved_state
    # render :embed, layout: false
    render layout: 'embed'
  end

  def map
    @labs = Lab.with_approved_state
  end

  def list
    ## the country code is stored as lowercase in the db
    if params[:country]
      params['country'].downcase!
      # params['country'].upcase!
    end
    @labs = Lab.with_approved_state.order('LOWER(name) ASC').in_country_code(params['country']).page(params['page']).per(params['per'])
    render layout: 'embed'
  end

  def mapdata
    @labs = Lab.with_approved_state.select(:id, :name, :slug, :latitude, :longitude, :kind)
    render json: @labs, each_serializer: MapSerializer
  end

  def index
    ## the country code is stored as lowercase in the db
    if params[:country]
      params['country'].downcase!
      # params['country'].upcase!
    end
    all_labs = Lab.search_for(params[:query]).with_approved_state
    @countries = Lab.country_list_for all_labs
    @count = all_labs.size
    @labs = all_labs.order('LOWER(name) ASC').in_country_code(params['country']).page(params['page']).per(params['per'])

    respond_to do |format|
      format.html
      format.json { redirect_to "https://api.fablabs.io/0/labs.json" }
      # format.csv { send_data @labs.to_csv }
    end
  end

  def new
    @lab = current_user.created_labs.build
    @lab.employees.build
    @lab.links.build
    @lab.kind = Lab::KINDS[0]
    @lab.activity_status = Lab::ACTIVITY_STATUS[0]
    authorize_action_for @lab
  end

  def create
    @lab = current_user.created_labs.build lab_params
    @lab.employees.first.assign_attributes(user: current_user, lab: @lab)
    authorize_action_for @lab
    if @lab.save
      sends_emails('submitted')
      redirect_to labs_path, notice: 'Thanks for adding your lab. We shall review your application and be in touch.'
    else
      # @lab.employees.build if @lab.employees.empty?
      @lab.links.build
      render :new
    end
  end

  def show
    begin
      @lab = with_approved_or_pending_state(params[:id])
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_path, notice: 'Lab not found'
    end
    # @people = [@lab.creator]
    @employees = @lab.employees.includes(:user).active.order('employees.id ASC')
    @machines = @lab.machines.includes(:brand, :tags)
    @events = @lab.events.order('starts_at ASC').includes(:lab)
    @academics = @lab.academics.includes(:user).order('users.first_name ASC')
    @years = @academics.map(&:started_in).uniq.sort.reverse
    @nearby_labs = @lab.nearby_labs(false, 1000)
    @nearby_labs = @nearby_labs.limit(5) if @nearby_labs
    authorize_action_for @lab
  end

  def destroy
    @lab = Lab.friendly.find(params[:id])
    authorize_action_for @lab
    @lab.delete
    redirect_to labs_path, notice: 'Lab deleted'
  end

  def edit
    @lab = Lab.friendly.find(params[:id])
    @lab.links.build
    authorize_action_for @lab
  end

  def update
    @lab = Lab.friendly.find(params[:id])
    authorize_action_for @lab
    if @lab.update_attributes lab_params
      track_activity @lab
      update_workflow_state
      redirect_to lab_url(@lab), notice: 'Lab was successfully updated'
    else
      @lab.links.build
      render :edit
    end
  end

  def manage_admins
    @lab = Lab.friendly.find(params[:id])
    authorize_action_for @lab
    @admins = @lab.admins
    @users = User.all # - User.with_role(:admin) - [current_user]
  end

  def docs
    render template: "labs/docs/#{params[:page]}"
  end

  private

  def allow_iframe
    response.headers.delete 'X-Frame-Options'
    #  From http://jerodsanto.net/2013/12/rails-4-let-specific-actions-be-embedded-as-iframes/
  end

  def lab_params
    params.require(:lab).permit(
      :activity_status,
      :activity_start_at,
      :activity_inaugurated_at,
      :activity_closed_at,
      :avatar,
      :header,
      :kind,
      :parent_id,
      :referee_id,
      :tools_list,
      :geocomplete,
      :name,
      :blurb,
      :description,
      :slug,
      :address_1,
      :address_2,
      :city,
      :county,
      :postal_code,
      :country_code,
      :latitude,
      :longitude,
      :zoom,
      :address_notes,
      :phone,
      :email,
      :application_notes,
      :tools_list,
      :tools,
      :network,
      :programs,
      :improve_approval_application,
      capabilities: [],
      facilities_attributes: [:id, :thing_id, '_destroy'],
      links_attributes: [:id, :link_id, :url, '_destroy'],
      referee_approval_processes_attributes: [:referee_lab_id, '_destroy'],
      employees_attributes: %i[id job_title description]
    )
  end
end
