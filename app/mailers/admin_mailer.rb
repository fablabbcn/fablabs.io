class AdminMailer < ActionMailer::Base
  # if Rails.env.test?
    default from: "FabLabs <admin_notifications@fablabs.io>",
            to: "john@bitsushi.com"
  # else
  #   default from: "FabLabs <notifications@fablabs.io>",
  #           to: User.with_role(:admin).pluck(:email)
  # end

  def lab_submitted lab
    @lab = lab
    mail(subject: "#{@lab} submitted")
  end

end
