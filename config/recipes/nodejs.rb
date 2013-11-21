namespace :nodejs do
  desc "Install Node.js"
  task :install, roles: :app do
    run "#{sudo} apt-get install -y python-software-properties"
    run "#{sudo} add-apt-repository -y ppa:chris-lea/node.js"
    run "#{sudo} apt-get update -y"
    run "#{sudo} apt-get install -y nodejs"
  end
  after "deploy:install", "nodejs:install"
end
