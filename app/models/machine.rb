class Machine < Thing

  after_save :discourse_sync_if_needed, if: -> { Figaro.env.discourse_enabled }

  def to_param
    slug
  end

  def async_discourse_sync
    DiscourseMachineWorker.perform_async(self.id)
  end

  def discourse_sync
    DiscourseService::Machine.new(self).sync
  end

  private

  def discourse_sync_if_needed
    if (changes.keys & ["name", "description"]).present?
      async_discourse_sync
    end
  end
end
