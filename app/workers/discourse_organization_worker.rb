class DiscourseOrganizationWorker
  include Sidekiq::Worker
  def perform(organization_id)
    organization = Organization.find(organization_id)
    organization.discourse_sync
  end
end
