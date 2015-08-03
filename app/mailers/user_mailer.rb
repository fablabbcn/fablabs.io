Premailer::Rails.config.merge!(link_query_string: 'from=f10m001')

class UserMailer < ActionMailer::Base

  default from: "FabLabs.io <notifications@fablabs.io>"

  # why doesn't this work??
  %w(submitted approved rejected removed referee_approve add_more_info need_more_info).each do |action|
    define_method("lab_#{action}") do |lab_id|
      begin
        @lab = Lab.find(lab_id)
        users = (@lab.direct_admins + [@lab.creator]).compact.uniq
        users.each do |user|
          @user = user
          mail(to: @user.email_string, subject: "[#{@lab}] #{action.capitalize}")
        end
        if @lab.referee_id
          @referee = @lab.referee
          users = (@referee.direct_admins + [@referee.creator]).compact.uniq
          users.each do |user|
            @user = user
            mail(to: @user.email_string, subject: "[Fablabs.io] #{@lab} #{action.capitalize}")
          end
        end
      rescue ActiveRecord::RecordNotFound
      end
    end
  end

  def fab10 user
    @user = user
    mail(reply_to: "info@fab10.org", to: @user.email_string, subject: "FAB10 Discount Code")
  end

  def employee_approved employee_id
    begin
      @employee = Employee.find(employee_id)
      @user = @employee.user
      mail(to: @user.email_string, subject: "[#{@employee.lab}] Employee Application Approval")
    rescue ActiveRecord::RecordNotFound
    end
  end

  def welcome user_id
    begin
      @user = User.find(user_id)
      mail(to: @user.email_string, subject: "Account Confirmation Instructions")
    rescue ActiveRecord::RecordNotFound
    end
  end

  def verification user_id
    begin
      @user = User.find(user_id)
      mail(to: @user.email_string, from: "FabLabs.io <support@fablabs.io>", subject: "Email Verification Instructions")
    rescue ActiveRecord::RecordNotFound
    end
  end

  def account_recovery_instructions user_id
    begin
      @user = User.find(user_id)
      mail(to: @user.email_string, from: "FabLabs.io <support@fablabs.io>", subject: "Account Recovery Instructions")
    rescue ActiveRecord::RecordNotFound
    end
  end

end
