require "bundler/capistrano"

set :recipes, "config/recipes"

load "#{recipes}/base"
load "#{recipes}/figaro"
load "#{recipes}/blacklist"
load "#{recipes}/nginx"
load "#{recipes}/unicorn"
# load "config/recipes/postgresql"
load "#{recipes}/nodejs"
load "#{recipes}/rbenv"
load "#{recipes}/security"
load "#{recipes}/check"
# load "config/recipes/monit"

server "tesla.fablabs.io", :web, :app, :db, primary: true
# server "sagan.fablabs.io", :db

set :application, "fablabs"
set :user, "deployer"
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
