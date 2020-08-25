module DiscourseService
  module User
    class << self
      def client
        @client ||= DiscourseApi::Client.new(
          ENV['DISCOURSE_ENDPOINT'],
          ENV['DISCOURSE_API_KEY'],
          ENV['DISCOURSE_API_USERNAME']
        )
      end

      def sync_sso(user)
        res = client.sync_sso(
          sso_secret: ENV['DISCOURSE_SSO_SECRET'],
          name: user.full_name,
          username: user.username,
          email: user.email,
          external_id: user.id
        )

        user.update_column(:discourse_id, res["id"])
        res
      end

      def logout(user)
        unless user.discourse_id
          sync_sso(user)
        end

        user.reload
        client.log_out(user.discourse_id)
      end
    end
  end
end
