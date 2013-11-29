class AdminMailer < ActionMailer::Base

  default from: "FabLabs <admin_notifications@fablabs.io>"

  def lab_submitted lab
    @lab = lab
    mail(subject: "#{@lab} submitted", to: User.admin_emails)
  end

end
