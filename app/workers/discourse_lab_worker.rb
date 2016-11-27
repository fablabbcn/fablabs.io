class DiscourseLabWorker
  include Sidekiq::Worker
  def perform(lab_id)
    lab = Lab.find(lab_id)
    lab.discourse_sync
  end
end
