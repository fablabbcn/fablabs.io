module ApproveWorkflow

  def self.included(base)
    base.workflow_column :workflow_state

    base.workflow do
      state :unverified do
        event :referee_approves, transition_to: :referee_approval
        event :request_more_info, transition_to: :need_more_info
        event :referee_requests_admin_approval, transition_to: :admin_approval
        event :referee_rejects, transition_to: :might_need_review
      end
      state :need_more_info do
        event :lab_adds_info, transition_to: :more_info_added
      end
      state :referee_approval do
        event :referee_approves, transition_to: :approved
        event :referee_rejects, transition_to: :undecided
        event :request_more_info, transition_to: :need_more_info
        event :referee_requests_admin_approval, transition_to: :admin_approval
      end
      state :undecided do
        event :referee_approves, transition_to: :approved
        event :referee_rejects, transition_to: :rejected
        event :request_more_info, transition_to: :need_more_info
        event :referee_requests_admin_approval, transition_to: :admin_approval
      end
      state :might_need_review do
        event :referee_approves, transition_to: :undecided
        event :referee_rejects, transition_to: :rejected
        event :request_more_info, transition_to: :need_more_info
        event :referee_requests_admin_approval, transition_to: :admin_approval
      end
      state :admin_approval do
        event :admin_approves, transition_to: :approved
        event :admin_rejects, transition_to: :rejected
        event :request_more_info, transition_to: :need_more_info
      end
      state :approved do
        event :remove, transitions_to: :removed
      end
      state :more_info_added
      state :rejected
      state :removed
    end
  end
end
