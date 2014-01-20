class AcademicsController < ApplicationController

  before_filter :require_login

  def new
    @lab = Lab.with_approved_state.friendly.find params[:lab_id]
    @academic = @lab.academics.build
    # authorize_action_for @academic
  end

  def edit
    @academic = current_user.academics.find(params[:id])
  end

  def create
    @lab = Lab.with_approved_state.friendly.find params[:lab_id]
    @academic = @lab.academics.new academic_params.merge({user: current_user})
    # authorize_action_for @academic
    if @academic.save
      track_activity @academic, @academic.user
      redirect_to lab_url(@lab), notice: "Thank you for applying"
    else
      render :new
    end
  end

  def update
    @academic = current_user.academics.find(params[:id])
    # authorize_action_for @employee
    if @academic.update_attributes academic_params
      # track_activity @employee, @employee.user
      redirect_to lab_url(@academic.lab), notice: "academic updated"
    else
      render :edit
    end
  end

#   def index
#     @lab = Lab.with_approved_state.friendly.find params[:lab_id]
#     @employees = @lab.employees
#   end

#   def approve
#     @employee = Employee.find(params[:id])
#     if @employee.approve!
#       UserMailer.delay.employee_approved(@employee.id)
#       track_activity @employee, @employee.user
#       redirect_to lab_employees_url(@employee.lab), notice: 'Employee approved'
#     else
#       redirect_to lab_employees_url(@employee.lab), notice: 'Failed'
#     end
#   end

#   def destroy
#     @employee = Employee.find(params[:id])
#     @employee.destroy
#     track_activity @employee, @employee.user
#     redirect_to lab_url(@employee.lab), notice: 'Employee removed'
#   end

#   def edit
#     @employee = Employee.find(params[:id])
#     authorize_action_for @employee
#   end

private

  def academic_params
    params.require(:academic).permit!
    # (
    #   :started_in,
    #   :graduated_in,
    #   :url,
    #   :final_project_name,
    #   :final_project_description
    # )
  end

end
