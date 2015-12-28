class RefereeMailer < ActionMailer::Base

  default from: "FabLabs <notifications@fablabs.io>"

  %w(submitted approved rejected removed referee_approved referee_rejected more_info_needed more_info_added).each do |action|
    define_method("lab_#{action}") do |lab_id|
      begin
        @lab = Lab.find(lab_id)
        if @lab.referee_id
          @referee = @lab.referee
          users = (@referee.direct_admins + [@referee.creator]).compact.uniq
          users.each do |user|
            @user = user
            mail(to: user.email_string, subject: "[Fablabs.io] #{@lab} #{action.capitalize}")
          end
        elsif @lab.referee_approval_processes
          @lab.referee_approval_processes.map{ |process| process.referee_lab }.each do |ref|
            users = (ref.direct_admins + [ref.creator]).compact.uniq
            users.each do |user|
              @user = user
              mail(to: user.email_string, subject: "[Fablabs.io] #{@lab} #{action.capitalize}")
            end
          end
        end
      rescue ActiveRecord::RecordNotFound
      end
    end
  end
end
