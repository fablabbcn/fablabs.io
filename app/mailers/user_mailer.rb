class UserMailer < ActionMailer::Base
  default from: "notifications@fabfoundationworld.org"

  def lab_submitted lab
    @lab = lab
    @user = @lab.creator
    mail(to: "#{@user} <#{@user.email}>", subject: "#{@lab} submitted")
  end

  def lab_approved lab
    @lab = lab
    @user = @lab.creator
    mail(to: "#{@user} <#{@user.email}>", subject: "#{@lab} approved!")
  end

  def welcome user
    @user = user
    mail(to: "#{@user} <#{@user.email}>", subject: "Welcome")
  end

end
