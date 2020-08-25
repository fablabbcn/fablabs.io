module DiscourseService
  class Project < Entity
    def name
      "Discussion about #{@entity.title}"
    end

    def description
      "#{@entity.description}

This is the general thread for discussing the project; the thread is also visible on its page at #{url}
      "
    end

    def url
      Rails.application.routes.url_helpers.project_url(@entity, host: ENV['FABLAB_URL'])
    end

    def category
      ENV['DISCOURSE_PROJECT_CATEGORY']
    end

    def creator
      @entity.owner
    end
  end
end
