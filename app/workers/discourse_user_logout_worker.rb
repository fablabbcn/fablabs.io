class DiscourseUserLogoutWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    DiscourseService::User.logout(user)
  end
end
