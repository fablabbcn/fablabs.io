module LabWorkflow

  extend ActiveSupport::Concern
  include Workflow

  workflow do
    unverified_state
    more_info_needed_state
    more_info_added_state
    referee_approved_state
    state :approved do
      event :remove, transitions_to: :removed
    end
    state :rejected
    state :removed
  end

  def unverified_state
    state :unverified do
      event :referee_approve, transition_to: :referee_approved
      event :approve, transitions_to: :approved
      event :need_more_info, transitions_to: :more_info_needed
      event :reject, transitions_to: :rejected
    end
  end

  def referee_approved_state
    state :referee_approved do
      event :approve, transitions_to: :approved
      event :need_more_info, transitions_to: :more_info_needed
      event :reject, transitions_to: :rejected
    end
  end

  def more_info_needed
    state :more_info_needed do
      event :add_more_info, transitions_to: :more_info_added
      event :referee_approve, transition_to: :referee_approved
      event :approve, transitions_to: :approved
      event :reject, transitions_to: :rejected
    end
  end

  def more_info_added_state
    state :more_info_added do
      event :need_more_info, transitions_to: :more_info_needed
      event :referee_approve, transition_to: :referee_approved
      event :approve, transitions_to: :approved
      event :reject, transitions_to: :rejected
    end
  end

end
