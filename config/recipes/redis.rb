set_default :redis_version, "2.8.0"

namespace :redis do
  desc "Install rbenv, Ruby, and the Bundler gem"
  task :install, roles: :app do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install build-essential tcl8.5"
    run "wget http://download.redis.io/releases/redis-#{redis_version}.tar.gz"
    run "tar xzf redis-#{redis_version}.tar.gz"
    run "rm redis-#{redis_version}.tar.gz"
    run "cd redis-#{redis_version} && #{sudo} make install && make test && make clean"
    p "Now login and run 'sudo ./install_server.sh'"
  end
  after "deploy:install", "redis:install"
end
