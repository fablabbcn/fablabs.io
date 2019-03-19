module DiscourseService
  class Entity
    def initialize(entity)
      @entity = entity
    end

    def discourse_id
      @entity.discourse_id
    end

    def sync
      if discourse_id
        response = client.update_topic(discourse_id, entity_params)
        @entity.update_columns(discourse_errors: nil)
      else
        response = client.create_topic(entity_params)
        @entity.update_columns(discourse_id: response['topic_id'], discourse_errors: nil)
      end
    rescue ArgumentError => e
      @entity.update_column(:discourse_errors, e.message)
    end

    def client
      DiscourseService::Client.instance
    end

    def entity_params
      params = {title: name, raw: description, category: category}
      params[:api_username] = creator.username if creator
      params
    end

    def creator
      @entity.owner
    end
  end
end
