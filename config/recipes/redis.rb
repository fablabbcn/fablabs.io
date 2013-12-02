# set_default :redis_version, "2.8.1"

namespace :redis do
  desc "Install rbenv, Ruby, and the Bundler gem"
  task :install, roles: :app do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install build-essential tcl8.5"
    run "wget http://download.redis.io/redis-stable.tar.gz"
    run "tar xvzf redis-stable.tar.gz"
    run "rm redis-stable.tar.gz"
    run "cd redis-stable && #{sudo} make && #{sudo} make install && #{sudo} make clean"
    p "Now login and run 'sudo ./install_server.sh'"
  end
  after "deploy:install", "redis:install"
end
