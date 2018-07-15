class CreateApprovalWorkflowLogs < ActiveRecord::Migration
  def change
    create_table :approval_workflow_logs do |t|
      t.string :lab_id
      t.string :user_id
      t.string :workflow_state
      t.timestamps
    end

    add_index :approval_workflow_logs, :lab_id
    add_index :approval_workflow_logs, :user_id
    add_index :approval_workflow_logs, :workflow_state
  end
end
