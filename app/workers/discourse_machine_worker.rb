class DiscourseMachineWorker
  include Sidekiq::Worker
  def perform(machine_id)
    machine = Machine.friendly.find(machine_id)
    machine.discourse_sync
  end
end
