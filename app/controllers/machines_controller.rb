class MachinesController < ThingsController
  defaults :resource_class => Machine

  def show
    @machine = Machine.includes(:brand,:links).find(params[:id])
  end

protected
  def collection
    @machines ||= end_of_association_chain.includes(:brand, :tags)
  end
end
