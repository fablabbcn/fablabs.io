class DiscourseUserSyncWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)

    client = DiscourseApiClient.client

    res = client.sync_sso(
      sso_secret: Figaro.env.discourse_sso_secret,
      name: user.full_name,
      username: user.username,
      email: user.email,
      external_id: user.id
    )

    user.update_column(discourse_id, res["id"])
  end
end
