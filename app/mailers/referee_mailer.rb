class RefereeMailer < ActionMailer::Base

  default from: "FabLabs <notifications@fablabs.io>"

  %w(submitted approved rejected removed referee_approved referee_requested_admin_approval referee_rejected requested_more_info more_info_added).each do |action|
    define_method("lab_#{action}") do |lab_id, message, recipient|
      begin
        @lab = Lab.find(lab_id)
        lab_referee_mailer(action, message, recipient)

      rescue ActiveRecord::RecordNotFound
      end
    end
  end

  def lab_referee_mailer(action, message, recipient)
    @referee = Lab.find(recipient)
    users = (@referee.direct_admins + [@referee.creator]).compact.uniq.map { |u| u.email_string }
    users.join(", ")
    @user = @referee.creator
    mail(to: users, subject: "[Fablabs.io] #{@lab} #{action.capitalize} - #{message}")

  end
end
