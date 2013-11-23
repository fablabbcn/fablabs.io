set_default :ruby_version, "2.0.0-p353"

namespace :rbenv do
  desc "Install rbenv, Ruby, and the Bundler gem"
  task :install, roles: :app do
    run "#{sudo} apt-get -y install curl git-core"
    run "git clone https://github.com/sstephenson/rbenv.git ~/.rbenv"
    run "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> ~/.profile"
    run "echo 'eval \"$(rbenv init -)\"' >> ~/.profile"
    run ". ~/.profile"
    run "git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build"
    run "rbenv install #{ruby_version}"
    run "rbenv global #{ruby_version}"
    run "echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc"
    run "gem install bundler"
    run "rbenv rehash"
  end
  after "deploy:install", "rbenv:install"
end
