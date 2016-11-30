class DiscourseProjectWorker
  include Sidekiq::Worker
  def perform(project_id)
    project = Project.find(project_id)
    project.discourse_sync
  end
end
