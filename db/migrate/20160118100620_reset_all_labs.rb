class ResetAllLabs < ActiveRecord::Migration
  def change
    Lab.where("workflow_state IN (?)",["unverified", "more_info_needed", "more_info_added", "referee_approved"]).each do |lab|
      lab.update_attributes(workflow_state: "unverified") if lab.workflow_state != "unverified"
      UserMailer.delay.send("lab_reset", lab.id)
    end
  end
end
