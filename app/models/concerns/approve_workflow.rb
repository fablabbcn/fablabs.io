module ApproveWorkflow

  def self.included(base)
    base.workflow_column :workflow_state

    base.workflow do
      state :unverified do
        event :referee_approve, transition_to: :referee_approved
        event :approve, transitions_to: :approved
        event :need_more_info, transitions_to: :more_info_needed
        event :reject, transitions_to: :rejected
      end
      state :more_info_needed do
        event :add_more_info, transitions_to: :more_info_added
        event :referee_approve, transition_to: :referee_approved
        event :approve, transitions_to: :approved
        event :reject, transitions_to: :rejected
      end
      state :more_info_added do
        event :need_more_info, transitions_to: :more_info_needed
        event :referee_approve, transition_to: :referee_approved
        event :approve, transitions_to: :approved
        event :reject, transitions_to: :rejected
      end
      state :referee_approved do
        event :approve, transitions_to: :approved
        event :need_more_info, transitions_to: :more_info_needed
        event :reject, transitions_to: :rejected
      end
      state :approved do
        event :remove, transitions_to: :removed
      end
      state :rejected
      state :removed
    end
  end
end
