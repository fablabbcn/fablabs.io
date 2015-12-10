class CreateRefereeApprovalProcesses < ActiveRecord::Migration
  def change
    create_table :referee_approval_processes do |t|
      
      t.timestamps
    end

  end
end
