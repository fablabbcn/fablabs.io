module LabsOperations

  extend ActiveSupport::Concern

  def update_workflow_state
    if @lab.workflow_state == "more_info_needed"
      @lab.update_attributes workflow_state: "more_info_added"
      RefereeMailer.delay.lab_more_info_added(@lab.id)
    end
  end

  def with_approved_or_pending_state(lab_id)
    lab = Lab.friendly.find(lab_id)
    if ['approved', 'referee_approved', 'more_info_needed', 'more_info_added'].include? lab.workflow_state
      lab
    else
      raise ActiveRecord::RecordNotFound
    end
  end

end
