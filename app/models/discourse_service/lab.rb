module DiscourseService
  class Lab < Entity
    def name
      "Discussion about #{@entity.name}"
    end

    def description
      "#{@entity.description}

This is the general thread for discussing the lab; the thread is also visible on its page at #{url}
      "
    end

    def url
      "#{Figaro.env.url}/labs/#{@entity.slug}"
    end

    def category
      Figaro.env.discourse_lab_category
    end
  end
end
