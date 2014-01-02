class MachinesController < ThingsController
  defaults :resource_class => Machine

protected
  def collection
    @machines ||= end_of_association_chain.includes(:brand, :tags)
  end
end
