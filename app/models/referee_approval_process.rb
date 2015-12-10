class RefereeApprovalProcess < ActiveRecord::Base
  has_many :referre_labs, class_name: 'Lab'
  belongs_to :referred_lab, class_name: 'Lab'
  has_many :referee_accepted_labs, class_name: 'Lab'
  has_many :referee_refused_labs, class_name: 'Lab'

  def self.approval_ratio
    2/3
  end

  def self.admin_approval_ratio
    1/3
  end

  def self.num_referee_labs
    3
  end

  def ratio
    referee_accepted_labs.count / self.num_referee_labs
  end

  def referee_selected?
    return true if self.num_referee_labs == referee_labs.count
  end

  def consensus?
    return true if referee_accepted_labs.count + referee_refused_labs.count == referee_labs.count
  end

  def referee_labs_complete?
    return true if ( referee_selected? and consensus? )
  end

  def is_approved?
    return true if (referee_labs_complete? and ( ratio >= self.approval_ratio )
  end

  def needs_admin_approval?
    return true if referee_labs_complete? and ( ratio < self.approval_ratio ) and ( ratio >= self.admin_approval_ratio )
  end

  def is_rejected?
    return true if referee_labs_complete? and ( ratio < self.admin_approval_ratio )
  end

end
