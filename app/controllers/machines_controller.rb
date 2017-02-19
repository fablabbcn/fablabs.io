class MachinesController < ThingsController

  before_filter :require_login, except: [:index, :show, :search]

  defaults :resource_class => Machine

  def show
    @machine = Machine.includes(:brand,:links).friendly.find(params[:id])
  end

  protected

  def resource
    @machine ||= collection.friendly.find(params[:id])
  end

  def collection
    @machines ||= end_of_association_chain.includes(:brand, :tags)
  end
end
