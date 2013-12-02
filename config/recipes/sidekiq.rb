set_default(:sidekiq_user) { user }
set_default(:sidekiq_lock) { "#{current_path}/tmp/sidekiq-lock" }
set_default(:sidekiq_pid) { "#{current_path}/tmp/pids/sidekiq.pid" }
set_default(:sidekiq_config) { "#{current_path}/config/sidekiq.yml" }
set_default(:sidekiq_log) { "#{shared_path}/log/sidekiq.log" }
set_default(:sidekiq_workers, 2)

namespace :sidekiq do
  desc "Setup Sidekiq initializer and app configuration"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    # template "sidekiq.rb.erb", sidekiq_config
    %w(sidekiq).each do |n|
      file = "#{n}_init"
      template "#{n}_init.erb", "/tmp/#{n}"
      run "chmod +x /tmp/#{n}"
      run "#{sudo} mv /tmp/#{n} /etc/init.d/#{n}"
      run "#{sudo} update-rc.d -f #{n} remove"
      run "#{sudo} update-rc.d -f #{n} defaults"
    end
  end
  after "deploy:setup", "sidekiq:setup"
end
