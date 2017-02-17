class DiscourseUserSyncWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    DiscourseService::User.sync_sso(user)
  end
end
