module VerifyWorkflow

  def self.included(base)
    base.workflow_column :workflow_state

    base.workflow do
      state :unverified do
        event :verify, transitions_to: :verified
        event :unverify, transitions_to: :unverified
      end
      state :verified do
        event :unverify, transitions_to: :unverified
      end
    end
  end
end
