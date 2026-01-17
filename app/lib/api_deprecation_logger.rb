class ApiDeprecationLogger
  def self.log(request)
    logger.warn(
      host: request.host,
      method: request.method,
      path: request.fullpath,
      user_agent: request.user_agent
    )
  end

  def self.logger
    @logger ||= begin
      l = ActiveSupport::Logger.new(
        Rails.root.join('log/api_deprecated.log')
      )
      l.formatter = Rails.logger.formatter
      l
    end
  end
end
