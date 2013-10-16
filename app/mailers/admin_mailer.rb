class AdminMailer < ActionMailer::Base
  default from: "admin_notifications@fabfoundationworld.org"

  def lab_submitted lab
    @lab = lab
    @user = 'john@bitsushi.com'
    mail(to: "#{@user} <#{@user}>", subject: "#{@lab} submitted")
  end

end
