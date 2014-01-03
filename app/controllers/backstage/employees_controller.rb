class Backstage::EmployeesController < Backstage::BackstageController

  def index
    @employees = Employee.includes(:lab, :user).with_unverified_state.order('id DESC')
  end

end
