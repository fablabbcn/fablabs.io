namespace :recoveries do

  desc "Delete recovery codes older than 7 days"
  task cleanup: :environment do
    expired = Recovery.where("created_at < ?", 7.days.ago)
    count = expired.count
    expired.delete_all
    puts "Deleted #{count} expired recovery codes."
  end

end
