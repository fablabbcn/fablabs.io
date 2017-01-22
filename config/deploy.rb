# load Rails for env vars
require File.expand_path('../application', __FILE__)
require "bundler/capistrano"
require "sidekiq/capistrano"
require "opbeat/capistrano"
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"
# require 'capistrano/maintenance'

set :bundle_flags,   "--deployment --verbose --without development test"

set :rails_env, "production"
set :recipes, "config/recipes"
# monit varnish redis
%w(varnish memcached monit base postgresql sidekiq redis logs figaro blacklist nginx logs unicorn nodejs rbenv security check mosh).each do |r|
  load "#{recipes}/#{r}"
end

server ENV['APP_SERVER'], :web, :app, :db, primary: true
# 146.185.179.183
# server "sagan.fablabs.io", :db

set :port, ENV['SSH_PORT']
set :application, "fablabs"
set :user, ENV['DEPLOY_USER']
set :password, ENV['DEPLOY_PASS']
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rake, "#{rake} --trace"
set :scm, "git"
set :repository, "git@github.com:fablabbcn/#{application}.git"
set :branch, "master"
set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :maintenance_template_path, File.expand_path("../recipes/templates/maintenance.html.erb", __FILE__)

# after "deploy", "refresh_sitemaps"
# task :refresh_sitemaps do
#   run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake sitemap:refresh"
# end

after "deploy", "deploy:migrate", "deploy:cleanup" # keep only the last 5 releases

before "bower:install", "bower:symlink"
after  "bower:install", "bower:prune"

before "deploy:assets:precompile", "bower:install"

namespace :bower do
  desc "Symlink shared components to current release"
  task :symlink, roles: :app do
    run "mkdir -p #{shared_path}/bower_components"
    run "ln -nfs #{shared_path}/bower_components #{latest_release}/vendor/assets/bower_components"
  end

  desc "Install the current Bower environment"
  task :install, roles: :app do
    run "cd #{latest_release} && /usr/bin/node /usr/bin/bower install --production --quiet"
  end

  desc "Uninstalls local extraneous packages"
  task :prune, roles: :app do
    run "cd #{latest_release} && /usr/bin/node /usr/bin/bower prune"
  end
end

require './config/boot'
# require 'airbrake/capistrano'
