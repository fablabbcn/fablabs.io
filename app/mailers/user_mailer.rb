class UserMailer < ActionMailer::Base
  default from: "from@example.com"

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

end
