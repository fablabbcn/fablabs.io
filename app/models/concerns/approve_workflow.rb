module ApproveWorkflow

  def self.included(base)
    base.workflow_column :workflow_state

    base.workflow do
      state :unverified do
        event :referee_approves, transition_to: :referee_approval
        event :request_more_info, transition_to: :need_more_info
        event :referee_requests_admin_approval, transition_to: :admin_approval
        event :referee_rejects, transition_to: :might_need_review
        event :approve, transition_to: :approved
        event :reject, transition_to: :rejected
        event :remove, transition_to: :removed
      end
      state :need_more_info do
        event :referee_approves, transition_to: :approved
        event :referee_rejects, transition_to: :undecided
        event :request_more_info, transition_to: :need_more_info
        event :referee_requests_admin_approval, transition_to: :admin_approval
        event :lab_adds_info, transition_to: :more_info_added
        event :approve, transition_to: :approved
        event :reject, transition_to: :rejected
        event :remove, transition_to: :removed
      end
      state :referee_approval do
        event :referee_approves, transition_to: :approved
        event :referee_rejects, transition_to: :undecided
        event :request_more_info, transition_to: :need_more_info
        event :referee_requests_admin_approval, transition_to: :admin_approval
        event :approve, transition_to: :approved
        event :reject, transition_to: :rejected
        event :remove, transition_to: :removed
      end
      state :undecided do
        event :referee_approves, transition_to: :approved
        event :referee_rejects, transition_to: :rejected
        event :request_more_info, transition_to: :need_more_info
        event :referee_requests_admin_approval, transition_to: :admin_approval
        event :approve, transition_to: :approved
        event :reject, transition_to: :rejected
        event :remove, transition_to: :removed
      end
      state :might_need_review do
        event :referee_approves, transition_to: :undecided
        event :referee_rejects, transition_to: :rejected
        event :request_more_info, transition_to: :need_more_info
        event :referee_requests_admin_approval, transition_to: :admin_approval
        event :approve, transition_to: :approved
        event :reject, transition_to: :rejected
        event :remove, transition_to: :removed
      end
      state :admin_approval do
        event :request_more_info, transition_to: :need_more_info
        event :approve, transition_to: :approved
        event :reject, transition_to: :rejected
        event :remove, transition_to: :removed
      end
      state :approved do
        event :remove, transitions_to: :removed
      end

      state :more_info_added do
        event :referee_approves, transition_to: :approved, :if => proc { lab.guardian == 1 }
        event :referee_approves, transition_to: :undecided, :if => proc { lab.guardian == 2 }
        event :referee_approves, transition_to: :referee_approval, :if => proc { lab.guardian == 3 }
        event :referee_approves, transitions_to: :might_need_review, :if => proc { lab.guardian == 4 }
        event :referee_rejects, transition_to: :rejected, :if => proc { lab.guardian == 0 }
        event :referee_rejects, transition_to: :might_need_review, :if => proc { lab.guardian == 4 }
        event :request_more_info, transition_to: :need_more_info
        event :referee_requests_admin_approval, transition_to: :admin_approval
        event :approve, transition_to: :approved
        event :reject, transition_to: :rejected
        event :remove, transition_to: :removed
      end
      state :rejected
      state :removed
    end
  end
end
