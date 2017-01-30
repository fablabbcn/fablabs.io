class MachinesController < ThingsController

  before_filter :require_login, only: [:new, :create, :update, :edit]
  
  defaults :resource_class => Machine

  def show
    @machine = Machine.includes(:brand,:links).find(params[:id])
  end

protected
  def collection
    @machines ||= end_of_association_chain.includes(:brand, :tags)
  end
end
