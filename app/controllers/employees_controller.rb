class EmployeesController < ApplicationController

  before_filter :require_login

  def new
    @lab = Lab.friendly.find params[:lab_id]
    @employee = @lab.employees.build
    authorize_action_for @employee
  end

  def create
    @lab = Lab.friendly.find params[:lab_id]
    @employee = @lab.employees.new employee_params.merge({user: current_user})
    authorize_action_for @employee
    if @employee.save
      redirect_to lab_url(@lab), notice: "Thank you for applying"
    else
      render :new
    end
  end

  def index
    @lab = Lab.friendly.find params[:lab_id]
    @employees = @lab.employees
  end

  def approve
    @employee = Employee.find(params[:id])
    if @employee.approve!
      redirect_to lab_employees_url(@employee.lab), notice: 'Employee approved'
    else
      redirect_to lab_employees_url(@employee.lab), notice: 'Failed'
    end
  end

private

  def employee_params
    params.require(:employee).permit(
      :user_id,
      :lab_id,
      :ordinal,
      :job_title,
      :email,
      :phone,
      :description
    )
  end

end
