class EmployeesController < ApplicationController

  before_action :require_login
  before_action :check_user_verification, only: [:new, :create]

  def new
    @lab = Lab.with_approved_state.friendly.find params[:lab_id]
    if current_user.applied_to?(@lab)
      redirect_to lab_url(@lab), notice: "You've already applied to work here"
    else
      @employee = @lab.employees.build
      authorize_action_for @employee
    end
  end

  def create
    @lab = Lab.with_approved_state.friendly.find params[:lab_id]
    @employee = @lab.employees.new employee_params.merge({user: current_user})
    authorize_action_for @employee
    if @employee.save
      track_activity @employee, @employee.user
      AdminMailer.employee_applied(@employee.id).deliver_now
      redirect_to lab_url(@lab), notice: "Thank you for applying"
    else
      render :new
    end
  end

  def update
    @employee = Employee.find params[:id]
    authorize_action_for @employee
    if @employee.update_attributes employee_params
      track_activity @employee, @employee.user
      redirect_to lab_employees_url(@employee.lab), notice: "Employee updated"
    else
      render :edit
    end
  end

  def index
    @lab = Lab.with_approved_state.friendly.find params[:lab_id]
    @employees = @lab.employees
  end

  def approve
    @employee = Employee.find(params[:id])
    if @employee.approve!
      UserMailer.employee_approved(@employee.id).deliver_now
      track_activity @employee, @employee.user
      redirect_to lab_employees_url(@employee.lab), notice: 'Employee approved'
    else
      redirect_to lab_employees_url(@employee.lab), notice: 'Failed'
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    track_activity @employee, @employee.user
    redirect_to lab_url(@employee.lab), notice: 'Employee removed'
  end

  def edit
    @employee = Employee.find(params[:id])
    authorize_action_for @employee
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
