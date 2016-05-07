class ApproveSpecificLab < ActiveRecord::Migration
  def change
    lab = Lab.where(slug: "lesfabriquesduponant").first
    bcn = Lab.where(slug: "fablabbcn").first
    cascina = Lab.where(slug: "fablabcascina").first
    lima = Lab.where(slug: "fablablima").first
    unless lab.nil?
      lab.workflow_state = "approved"
      lab.network = true
      lab.programs = true
      lab.tools = true
      lab.access = true
      lab.chart = true
      lab.referee_approval_processes.create(referred_lab: lab, referee_lab: bcn)
      lab.referee_approval_processes.create(referred_lab: lab, referee_lab: cascina)
      lab.referee_approval_processes.create(referred_lab: lab, referee_lab: lima)
      lab.save
    end
  end
end
