module DiscourseService
  class Project

    def initialize(project)
      @project = project
    end

    def discourse_id
      @project.discourse_id
    end

    def name
      "Discussion about #{@project.title}"
    end

    def description
      "#{@project.description}

This is the general thread for discussing the project; the thread is also visible on its page at #{url}
      "
    end

    def url
      Rails.application.routes.url_helpers.project_url(@project, host: Figaro.env.url)
    end

    def category
      Figaro.env.discourse_project_category
    end

    def project_params
      {title: name, raw: description, category: category}
    end

    def sync
      if discourse_id
        response = client.update_topic(discourse_id, project_params)
        @project.update_columns(discourse_errors: nil)
      else
        response = client.create_topic(project_params)
        @project.update_columns(discourse_id: response['topic_id'], discourse_errors: nil)
      end
    rescue ArgumentError => e
      @project.update_column(:discourse_errors, e.message)
    end

    def client
      DiscourseService::Client.instance
    end
  end
end
