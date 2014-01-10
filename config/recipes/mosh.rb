namespace :mosh do
  desc "Install mosh (ssh alternative)"
  task :install, roles: :app do
    run "#{sudo} apt-get -y install python-software-properties"
    run "#{sudo} add-apt-repository -y ppa:keithw/mosh"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install mosh"
  end
  after "deploy:install", "mosh:install"
end
