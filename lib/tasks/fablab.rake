namespace :fablab do
  task set_referees: :environment do
    Lab.approved_referees.each do |lab|
      lab.update_column(:is_referee, true)
    end
  end
end
