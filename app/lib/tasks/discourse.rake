namespace :discourse do

  desc 'Sync all sso users with discourse'
  task sync_users: :environment do
    User.find_each do |user|
      user.async_discourse_sync
    end
  end
  desc 'Sync all labs with discourse'
  task sync_labs: :environment do
    Lab.find_each do |lab|
      lab.async_discourse_sync
    end
  end

  desc 'Sync all machines with discourse'
  task sync_machines: :environment do
    Machine.find_each do |machine|
      machine.async_discourse_sync
    end
  end

  desc 'Sync all projects with discourse'
  task sync_projects: :environment do
    Project.find_each do |project|
      project.async_discourse_sync
    end
  end
end
