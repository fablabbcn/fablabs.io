namespace :discourse do
  desc 'Sync all labs with discourse'
  task sync: :environment do
    Lab.find_each do |lab|
      lab.async_discourse_sync
    end
  end
end
