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
      Rails.application.routes.url_helpers.project_url(@entity, host: Figaro.env.url)
    end

    def category
      Figaro.env.discourse_project_category
    end

    def creator
      @entity.owner
    end
  end
end
