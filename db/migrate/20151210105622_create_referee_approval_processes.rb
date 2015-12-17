class CreateRefereeApprovalProcesses < ActiveRecord::Migration
  def change
    create_table :referee_approval_processes do |t|
      t.belongs_to :referred_lab, index: true
      t.belongs_to :referee_lab, index: true
      t.boolean :approved
      t.timestamps
    end

  end
end
