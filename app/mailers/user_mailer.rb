class UserMailer < ActionMailer::Base
  default from: "FabLabs <notifications@fablabs.io>"

  # why doesn't this work??
  %w(submitted approved rejected removed).each do |action|
    define_method("lab_#{action}") do |lab|
      @lab = lab
      @user = @lab.creator
      mail(to: @user.email_string, subject: "#{@lab} #{action}")
    end
  end

  def employee_approved employee
    @employee = employee
    mail(to: employee.user.email_string, subject: "employee")
  end

  def welcome user_id
    @user = User.find(user_id)
    mail(to: @user.email_string, subject: "[FabLabs.io] Confirmation Instructions")
  end

  def verification user
    @user = user
    mail(to: @user.email_string, subject: "[FabLabs.io] Verification")
  end

  def account_recovery_instructions user
    @user = user
    mail(to: @user.email_string, from: "support@fablabs.io", subject: "Account Recovery Instructions")
  end

end
