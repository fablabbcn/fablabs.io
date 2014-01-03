class Backstage::EmployeesController < Backstage::BackstageController

  def index
    @employees = Employee.includes(:lab, :user).where("labs.workflow_state" => 'approved').with_unverified_state.order('employees.id DESC')
  end

end
