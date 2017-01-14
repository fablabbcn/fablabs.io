module DiscourseService
  class Machine < Entity
    def name
      "Discussion about #{@entity.brand.try(:name)} #{@entity.name}"
    end

    def description
      "#{name}

This is the general thread for discussing the machine; the thread is also visible on its page at #{url}
      "
    end

    def url
      Rails.application.routes.url_helpers.machine_url(@entity, host: Figaro.env.url)
    end

    def category
      Figaro.env.discourse_machine_category
    end
  end
end
