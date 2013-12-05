namespace :monit do
  desc "Install Monit"
  task :install do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install monit"
  end
  after "deploy:install", "monit:install"

  desc "Setup all Monit configuration"
  task :setup do
    monit_config "monitrc", "/etc/monit/monitrc"

    nginx
    postgresql
    memcached

    unicorn
    sidekiq

    redis
    syntax
    reload
  end
  after "deploy:setup", "monit:setup"

  %w(monitor unmonitor).each do |verb|
    desc "#{verb} monit"
    task verb.to_sym do
      run "#{sudo} /usr/bin/monit #{verb} unicorn_fablabs"
      3.times.map{|n| run "#{sudo} /usr/bin/monit #{verb} unicorn_fablabs_worker_#{n}"}
      run "#{sudo} /usr/bin/monit #{verb} sidekiq"
    end
  end

  before "deploy:update", "monit:unmonitor"
  after "deploy:cleanup", "monit:monitor"

  task(:nginx, roles: :web) { monit_config "nginx" }
  task(:postgresql, roles: :db) { monit_config "postgresql" }
  task(:unicorn, roles: :app) { monit_config "unicorn" }
  task(:redis, roles: :app) { monit_config "redis" }
  task(:sidekiq, roles: :app) { monit_config "sidekiq" }
  task(:memcached, roles: :app) { monit_config "memcached" }

  %w[start stop restart syntax reload].each do |command|
    desc "Run Monit #{command} script"
    task command do
      run "#{sudo} service monit #{command}"
    end
  end
end

def monit_config(name, destination = nil)
  destination ||= "/etc/monit/conf.d/#{name}.conf"
  template "monit/#{name}.erb", "/tmp/monit_#{name}"
  run "#{sudo} mv /tmp/monit_#{name} #{destination}"
  run "#{sudo} chown root #{destination}"
  run "#{sudo} chmod 600 #{destination}"
end
