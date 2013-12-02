set_default(:sidekiq_user) { user }
set_default(:sidekiq_lock) { "#{current_path}/tmp/sidekiq-lock" }
set_default(:sidekiq_pid) { "#{current_path}/tmp/pids/sidekiq.pid" }
set_default(:sidekiq_log) { "#{shared_path}/log/sidekiq.log" }
set_default(:sidekiq_workers, 2)

namespace :sidekiq do
  desc "Setup Sidekiq initializer and app configuration"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    # template "sidekiq.rb.erb", sidekiq_config
    %w(sidekiq workers).each do |n|
      file = "#{n}_init"
      template "#{file}.erb", "/tmp/#{file}"
      run "chmod +x /tmp/#{file}"
      run "#{sudo} mv /tmp/#{file} /etc/init.d/#{file}"
      run "#{sudo} update-rc.d -f #{file} remove"
      run "#{sudo} update-rc.d -f #{file} defaults"
    end
  end
  after "deploy:setup", "sidekiq:setup"
end
