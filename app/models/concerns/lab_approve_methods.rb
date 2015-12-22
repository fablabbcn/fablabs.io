module LabApproveMethods
  extend ActiveSupport::Concern

  def referee_approves(referee)
    referee_lab = referee.referee_lab(@lab.id)
    referee_process(referee_lab.id).update_attributes(approved: true) unless referee_lab.nil?
  end

  def referee_rejects(referee)
    referee_lab = referee.referee_lab(@lab.id)
    referee_process(referee_lab.id).update_attributes(approved: false) unless referee_lab.nil?
  end

  def referee_process(referee_lab_id)
    referee_approval_processes.where(referee_lab_id: referee_lab_id).first
  end

  def request_more_info(user)
    if user.is_referee? or user.has_role? :superadmin
      employees.update_all(workflow_state: :need_more_info)
    else
      raise 'Operation not permitted'
    end
  end

  def referee_requests_admin_approval(referee)
    if user.is_referee?
      employees.update_all(workflow_state: :admin_approval)
    else
      raise 'Operation not permitted'
    end
  end

  def lab_adds_info(user)
    employees.update_all(workflow_state: :more_info_added)
  end

  def more_info_added
    consensus
  end

  def consensus
    votes_up = referee_approval_processes.where(approved: true).count
    votes_down = referee_approval_processes.where(approved: false).count
    if votes_up >= 2
      update_attributes(workflow_state: :approved)
      employees.update_all(workflow_state: :approved)
    elsif votes_up == 1 and votes_down == 1
      update_attributes(workflow_state: :undecided)
    elsif votes_up == 1 and votes_down == 0
      update_attributes(workflow_state: :referee_approval)
    elsif votes_up == 0 and votes_down == 1
      update_attributes(workflow_state: :might_need_review)
    elsif votes_down >=2
      employees.update_all(workflow_state: :rejected)
      update_attributes(workflow_state: :rejected)
    end
  end

  def approve(admin)
    if admin.has_role? :superadmin
      update_attributes(workflow_state: :approved)
      employees.update_all(workflow_state: :approved)
      creator.add_role :admin, self
    else
      consensus
    end
  end

  def reject(admin)
    if admin.has_role? :superadmin
      update_attributes(workflow_state: :rejected)
      employees.update_all(workflow_state: :rejected)
    else
      consensus
    end
  end

  def remove(admin)
    if admin.has_role? :superadmin
      update_attributes(workflow_state: :removed)
      employees.update_all(workflow_state: :removed)
    else
      raise 'Operation not permitted'
    end
  end

end
