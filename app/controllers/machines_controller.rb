class MachinesController < ThingsController

  before_action :require_login, except: [:index, :show, :search]
  before_action :set_machine, only: [:show, :edit, :update, :destroy]

  def show; end
  def edit; end

  def index
    @machines = Machine.includes(:brand, :tags).page(params['page']).per(params['per'] || 20)
  end

  def new
    @machine = Machine.new
  end

  def create
    @machine = Machine.new(machine_params)
    if @machine.save
      redirect_to machine_path(@machine), notice: 'Machine created'
    end
  end

  def update
    if @machine.update(machine_params)
      redirect_to edit_machine_url @machine
    else
      render 'edit'
    end
  end

  protected

  def set_machine
    @machine = Machine.includes(:brand,:links).friendly.find(params[:id])
  end

  # TODO: These are attributes from the Things model.
  # They should live there instead, if this should be a re-usable polymorphic.
  # So far, Machine is the only one inhereting from Things
  def machine_params
    params.require(:machine).permit(
      :name,
      :brand_id,
      :description,
      :parent_id,
      :photo,
      :tag_list,
      :inventory_item,
      links_attributes: [ :id, :link_id, :description, :url, '_destroy' ],
      facilities_attributes: [:id, :lab_id],
      documents_attributes: [ :id, :image, :title, :description ]
    )
  end
end
