class UserMailer < ActionMailer::Base
  default from: "notifications@fabfoundationworld.org"

  %w(submitted approved).each do |action|
    define_method("lab_#{action}") do |lab|
      @lab = lab
      @user = @lab.creator
      mail(to: "#{@user} <#{@user.email}>", subject: "#{@lab} #{action}")
    end
  end

  def welcome user
    @user = user
    mail(to: "#{@user} <#{@user.email}>", subject: "Welcome")
  end

  def account_recovery_instructions user
    @user = user
    mail(to: "#{@user} <#{@user.email}>", from: "support@fabfoundationworld.org", subject: "Account Recovery Instructions")
  end

end
