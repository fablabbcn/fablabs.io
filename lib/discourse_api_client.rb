module DiscourseApiClient
  def self.client
    @client ||= DiscourseApi::Client.new(Figaro.env.discourse_endpoint,
                                         Figaro.env.discourse_api_key,
                                         Figaro.env.discourse_api_username)
  end
end
