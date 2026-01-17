module LabApproveMethods
  extend ActiveSupport::Concern

  def referee_approves(referee)
    process = referee_process(referee)
    process.update(approved: true) unless process.nil?
    consensus
  end

  def referee_rejects(referee)
    process = referee_process(referee)
    process.update(approved: false) unless process.nil?
    consensus
  end

  def referee_process(referee)
    referee_approval_processes.where(
      "referee_lab_id IN (?) AND approved IS ?", referee.admin_labs.map{ |u| u.resource_id }, nil
    ).first
  end

  def request_more_info(user)
    if user.is_referee? or user.has_role? :superadmin
      employees.update_all(workflow_state: :need_more_info)
    else
      raise 'Operation not permitted'
    end
  end

  def referee_requests_admin_approval(referee)
    if referee.is_referee?
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
      update(workflow_state: :approved)
      employees.update_all(workflow_state: :approved)
    elsif votes_up == 1 and votes_down == 1
      update(workflow_state: :undecided)
    elsif votes_up == 1 and votes_down == 0
      update(workflow_state: :referee_approval)
    elsif votes_up == 0 and votes_down == 1
      update(workflow_state: :might_need_review)
    elsif votes_down >=2
      employees.update_all(workflow_state: :rejected)
      update(workflow_state: :rejected)
    end
  end

  def guardian
    votes_up = referee_approval_processes.where(approved: true).count
    votes_down = referee_approval_processes.where(approved: false).count
    if votes_up >= 2
      return 1
    elsif votes_up == 1 and votes_down == 1
      return 2
    elsif votes_up == 1 and votes_down == 0
      return 3
    elsif votes_up == 0 and votes_down == 1
      return 4
    elsif votes_down >=2
      return 0
    end
  end

  def approve(admin)
    if admin.has_role? :superadmin
      update(workflow_state: :approved)
      employees.update_all(workflow_state: :approved)
      creator.add_role :admin, self
    else
      consensus
    end
  end

  def reject(admin)
    if admin.has_role? :superadmin
      update(workflow_state: :rejected)
      employees.update_all(workflow_state: :rejected)
    else
      consensus
    end
  end

  def remove(admin)
    if admin.has_role? :superadmin
      update(workflow_state: :removed)
      employees.update_all(workflow_state: :removed)
    else
      raise 'Operation not permitted'
    end
  end

end
