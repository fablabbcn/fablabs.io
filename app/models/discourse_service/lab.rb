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
      "#{ENV['FABLAB_URL']}/labs/#{@entity.slug}"
    end

    def category
      ENV['DISCOURSE_LAB_CATEGORY']
    end

    def creator
      @entity.creator
    end
  end
end
