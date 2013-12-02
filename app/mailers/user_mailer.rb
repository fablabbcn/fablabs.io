class UserMailer < ActionMailer::Base

  default from: "FabLabs.io <notifications@fablabs.io>"

  # why doesn't this work??
  %w(submitted approved rejected removed).each do |action|
    define_method("lab_#{action}") do |lab|
      @lab = lab
      users = (@lab.direct_admins + [@lab.creator]).uniq
      users.each do |user|
        @user = user
        mail(to: @user.email_string, subject: "#{ENV["EMAIL_SUBJECT_PREFIX"]}#{@lab} #{action.capitalize}")
      end
    end
  end

  def employee_approved employee
    @employee = employee
    @user = employee.user
    mail(to: @user.email_string, subject: "#{ENV["EMAIL_SUBJECT_PREFIX"]}Employee Application Approval")
  end

  def welcome user_id
    @user = User.find(user_id)
    mail(to: @user.email_string, subject: "#{ENV["EMAIL_SUBJECT_PREFIX"]}Confirmation Instructions")
  end

  def verification user
    @user = user
    mail(to: @user.email_string, from: "FabLabs.io <support@fablabs.io>", subject: "#{ENV["EMAIL_SUBJECT_PREFIX"]}Verification")
  end

  def account_recovery_instructions user
    @user = user
    mail(to: @user.email_string, from: "FabLabs.io <support@fablabs.io>", subject: "#{ENV["EMAIL_SUBJECT_PREFIX"]}Account Recovery Instructions")
  end

end
