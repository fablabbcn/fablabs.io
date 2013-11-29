class UserMailer < ActionMailer::Base
  default from: "FabLabs <notifications@fablabs.io>"

  %w(submitted approved rejected).each do |action|
    define_method("lab_#{action}") do |lab|
      @lab = lab
      @user = @lab.creator
      mail(to: @user.email_string, subject: "#{@lab} #{action}")
    end
  end

  # def role_added role, user
  #   @user = user
  #   @role = role
  #   mail(to: @user.email_string, subject: "Role Added")
  # end

  # def role_removed role, user
  #   @user = user
  #   @role = role
  #   mail(to: @user.email_string, subject: "Role Removed")
  # end

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
