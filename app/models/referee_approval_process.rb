class RefereeApprovalProcess < ActiveRecord::Base
  belongs_to :referee_lab, class_name: 'Lab'
  belongs_to :referred_lab, class_name: 'Lab'
  # referee_lab and referred_lab need to be different

  def self.approval_ratio
    2/3
  end

  def self.admin_approval_ratio
    1/3
  end

  def self.num_referee_labs
    3
  end

end
