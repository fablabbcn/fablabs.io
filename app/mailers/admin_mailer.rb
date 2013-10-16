class AdminMailer < ActionMailer::Base
  if Rails.env.test?
    default from: "admin_notifications@fabfoundationworld.org",
            to: "john@bitsushi.com"
  else
    default from: "admin_notifications@fabfoundationworld.org",
            to: User.with_role(:admin).pluck(:email)
  end

  def lab_submitted lab
    @lab = lab
    mail(subject: "#{@lab} submitted")
  end

end
