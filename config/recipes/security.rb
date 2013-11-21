namespace :security do
  desc "Install ufw"
  task :ufw, roles: :app do
    run "#{sudo} apt-get -y install ufw"
    run "#{sudo} ufw allow 22"
    run "#{sudo} ufw allow 80"
    run "#{sudo} ufw --force enable"
  end
  after "deploy:install", "security:ufw"

  desc "Install fail2ban"
  task :fail2ban, roles: :app do
    run "#{sudo} apt-get -y install fail2ban"
  end
  after "deploy:install", "security:fail2ban"
end
