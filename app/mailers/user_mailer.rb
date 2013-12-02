class UserMailer < ActionMailer::Base

  default from: "FabLabs.io <notifications@fablabs.io>"

  # why doesn't this work??
  %w(submitted approved rejected removed).each do |action|
    define_method("lab_#{action}") do |lab_id|
      begin
        @lab = Lab.find(lab_id)
        users = (@lab.direct_admins + [@lab.creator]).compact.uniq
        users.each do |user|
          @user = user
          mail(to: @user.email_string, subject: "#{ENV["EMAIL_SUBJECT_PREFIX"]}#{@lab} #{action.capitalize}")
        end
      rescue ActiveRecord::RecordNotFound
      end
    end
  end

  def employee_approved employee_id
    begin
      @employee = Employee.find(employee_id)
      @user = @employee.user
      mail(to: @user.email_string, subject: "#{ENV["EMAIL_SUBJECT_PREFIX"]}Employee Application Approval")
    rescue ActiveRecord::RecordNotFound
    end
  end

  def welcome user_id
    begin
      @user = User.find(user_id)
      mail(to: @user.email_string, subject: "#{ENV["EMAIL_SUBJECT_PREFIX"]}Confirmation Instructions")
    rescue ActiveRecord::RecordNotFound
    end
  end

  def verification user_id
    begin
      @user = User.find(user_id)
      mail(to: @user.email_string, from: "FabLabs.io <support@fablabs.io>", subject: "#{ENV["EMAIL_SUBJECT_PREFIX"]}Verification")
    rescue ActiveRecord::RecordNotFound
    end
  end

  def account_recovery_instructions user_id
    begin
      @user = User.find(user_id)
      mail(to: @user.email_string, from: "FabLabs.io <support@fablabs.io>", subject: "#{ENV["EMAIL_SUBJECT_PREFIX"]}Account Recovery Instructions")
    rescue ActiveRecord::RecordNotFound
    end
  end

end
