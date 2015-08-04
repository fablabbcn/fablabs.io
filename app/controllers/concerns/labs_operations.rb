module LabsOperations

  extend ActiveSupport::Concern

  def update_workflow_state
    @lab.update_attributes workflow_state: "more_info_added" if @lab.workflow_state == "more_info_needed"
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
