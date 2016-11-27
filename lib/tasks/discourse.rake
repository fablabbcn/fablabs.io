namespace :discourse do
  desc 'Sync all labs with discourse'
  task sync: :environment do

    Lab.find_each do |lab|
      p lab.id
      begin
        DiscourseService::Lab.new(lab).sync
      rescue => e
        p e.message
      end
    end

  end
end
