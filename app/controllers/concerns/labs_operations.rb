module LabsOperations
  extend ActiveSupport::Concern

  def update_workflow_state
    if @lab.workflow_state == "more_info_needed"
      @lab.update_attributes workflow_state: "more_info_added"
      RefereeMailer.lab_more_info_added(@lab.id).deliver_now
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
    users = (@lab.direct_admins + [@lab.creator]).compact.uniq
    users.each do |user|
      UserMailer.send("lab_#{verbed}", @lab.id, user.id).deliver_now
    end

    mails_referees(verbed)
  end

  def lab_log_workflow_action(verb)
    @lab.approval_workflow_logs.create!(lab_id:         @lab.id,
                                        user_id:        current_user.id,
                                        workflow_state: verb)
  end

  def sends_emails(action)
    UserMailer.send("lab_#{action}", @lab.id, @lab.creator.id).deliver_now
    AdminMailer.send("lab_#{action}", @lab.id).deliver_now

    mails_referees(action)
  end

  def mails_referees(action)
    if @lab.referee_id
      @referee = @lab.referee
      message = "You are the unique referee for this lab, please take action"
      RefereeMailer.send("lab_#{action}", @lab.id, message, @referee.id).deliver_now
    end

    if not @lab.referee_approval_processes.empty?
      message = "You are one of the lab referees, please take action"
      @lab.referee_approval_processes.each do |process|
        referee = process.referee_lab
        RefereeMailer.send("lab_#{action}", @lab.id, message, referee).deliver_now
      end
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
