class AdminMailer < ActionMailer::Base

  default from: "FabLabs <admin_notifications@fablabs.io>"

  def lab_submitted lab
    @lab = lab
    mail(subject: "#{ENV["EMAIL_SUBJECT_PREFIX"]}#{@lab} submitted", to: User.admin_emails)
  end

  def employee_applied employee
    @employee = employee

    @employee.lab.admins.each do |admin|
      @admin = admin
      mail(to: admin.email_string, subject: "##{ENV["EMAIL_SUBJECT_PREFIX"]}#{@employee.lab} Employee Application")
    end
  end

end
