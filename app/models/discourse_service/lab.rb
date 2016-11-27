module DiscourseService
  class Lab
    def initialize(lab)
      @lab = lab
    end

    def discourse_id
      @lab.discourse_id
    end

    def name
      @lab.name
    end

    def description
      @lab.description
    end

    def category
      Figaro.env.discourse_lab_category
    end

    def lab_params
      {title: name, raw: description, category: category}
    end

    def sync
      if discourse_id
        response = client.update_topic(discourse_id, lab_params)
        @lab.update_columns(discourse_errors: nil)
      else
        response = client.create_topic(lab_params)
        @lab.update_columns(discourse_id: response['topic_id'], discourse_errors: nil)
      end
    rescue ArgumentError => e
      @lab.update_column(:discourse_errors, e.message)
    end

    def client
      DiscourseService::Client.instance
    end
  end
end
