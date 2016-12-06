module DiscourseService
  class Machine

    def initialize(machine)
      @machine = machine
    end

    def discourse_id
      @machine.discourse_id
    end

    def name
      "Discussion about #{@machine.brand.try(:name)} #{@machine.name}"
    end

    def description
      "#{name}

This is the general thread for discussing the machine; the thread is also visible on its page at #{url}
      "
    end

    def url
      Rails.application.routes.url_helpers.machine_url(@machine, host: Figaro.env.url)
    end

    def category
      Figaro.env.discourse_machine_category
    end

    def machine_params
      {title: name, raw: description, category: category}
    end

    def sync
      if discourse_id
        response = client.update_topic(discourse_id, machine_params)
        @machine.update_columns(discourse_errors: nil)
      else
        response = client.create_topic(machine_params)
        @machine.update_columns(discourse_id: response['topic_id'], discourse_errors: nil)
      end
    rescue ArgumentError => e
      @machine.update_column(:discourse_errors, e.message)
    end

    def client
      DiscourseService::Client.instance
    end
  end
end
