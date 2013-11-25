namespace :varnish do
  desc "Install varnish"
  task :install, roles: :app do
    run "curl http://repo.varnish-cache.org/debian/GPG-key.txt | #{sudo} apt-key add -"
    run "echo 'deb http://repo.varnish-cache.org/ubuntu/ precise varnish-3.0' | #{sudo} tee -a /etc/apt/sources.list"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install varnish"
  end
  after "deploy:install", "varnish:install"
end
