# load Rails for env vars
require File.expand_path('../application', __FILE__)
require "bundler/capistrano"

set :recipes, "config/recipes"
# postgresql
# monit
%w(base logs figaro blacklist nginx logs unicorn nodejs rbenv security check).each do |r|
  load "#{recipes}/#{r}"
end

server "tesla.fablabs.io", :web, :app, :db, primary: true
# server "sagan.fablabs.io", :db

set :port, ENV['SSH_PORT']
set :application, "fablabs"
set :user, ENV['DEPLOY_USER']
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rake, "#{rake} --trace"
set :scm, "git"
set :repository, "git@github.com:johnrees/#{application}.git"
set :branch, "master"
set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :maintenance_template_path, File.expand_path("../recipes/templates/maintenance.html.erb", __FILE__)

after "deploy", "deploy:cleanup" # keep only the last 5 releases
