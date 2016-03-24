class AddActionToRefereeApprovalProcesses < ActiveRecord::Migration
  def change
    add_column :referee_approval_processes, :action, :string, :default => 'pending'
  end
end
