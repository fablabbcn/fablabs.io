class Backstage::EmployeesController < Backstage::BackstageController
  before_filter :require_admin

  def index
    @employees = Employee.includes(:lab, :user).where("labs.workflow_state" => 'approved').with_unverified_state.order('employees.id DESC')
  end

  private
    def require_admin
      if current_user
        unless current_user.has_role? :superadmin
          return redirect_to backstage_labs_url, notice: "Not authorized"
        end
      else
        return redirect_to signin_url
      end
    end

end
