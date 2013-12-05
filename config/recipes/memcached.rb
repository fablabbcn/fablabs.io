namespace :memcached do
  desc "Install Memcached"
  task :install do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install memcached"
  end
  after "deploy:install", "memcached:install"
end
