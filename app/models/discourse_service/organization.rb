module DiscourseService
  class Organization < Entity
    def name
      "Discussion about #{@entity.name}"
    end

    def description
      "This is the general thread for discussing the organization; the thread is also visible on its page at #{url}
      "
    end

    def url
      Rails.application.routes.url_helpers.organization_url(@entity, host: ENV['FABLAB_URL'])
    end

    def category
      ENV['DISCOURSE_ORGANIZATION_CATEGORY']
    end
  end
end
