module LabsOperations
  extend ActiveSupport::Concern

  def update_workflow_state
    if @lab.workflow_state == "more_info_needed"
      @lab.update_attributes workflow_state: "more_info_added"
      RefereeMailer.delay.lab_more_info_added(@lab.id)
      @lab.more_info_added
    end
  end

  def with_approved_or_pending_state(lab_id)
    lab = Lab.friendly.find(lab_id)
    if intermediate_states.include? lab.workflow_state
      lab
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def lab_send_action(verbed)
    UserMailer.delay.send("lab_#{verbed}", @lab.id)
    RefereeMailer.delay.send("lab_#{verbed}", @lab.id)
  end

  def record_user_action(verbed, current_user)
    if current_user.is_referee_of_lab @lab.id
      process = current_user.referee_approval_processes.where(referred_lab_id: @lab.id).first
    end
  end

  private

    def intermediate_states
      ['approved',
       'unverified',
       'need_more_info',
       'undecided',
       'might_need_review',
       'more_info_added',
       'admin_approval'
     ]
    end

    def action_to_verb
      {
        approve: "approved",
        reject: "rejected",
        remove: "removed",
        referee_approves: "referee_approved",
        referee_rejects: "referee_rejected",
        referee_requests_admin_approval: "referee_requested_admin_approval",
        request_more_info: "requested_more_info"
      }
    end

end
