module LabsOperations

  extend ActiveSupport::Concern

  def with_approved_or_pending_state(lab_id)
    lab = Lab.find(lab_id)
    if ['approved', 'referee_approved', 'more_info_needed', 'more_info_added'].include? lab.workflow_state
      lab.friendly
    else
      raise ActiveRecord::RecordNotFound
    end
  end

end
