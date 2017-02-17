module DiscourseService
  module User
    class << self
      def client
        @client ||= DiscourseApi::Client.new(Figaro.env.discourse_endpoint,
                                            Figaro.env.discourse_api_key,
                                            Figaro.env.discourse_api_username)
      end

      def sync_sso(user)
        res = client.sync_sso(
          sso_secret: Figaro.env.discourse_sso_secret,
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
