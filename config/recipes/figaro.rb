namespace :figaro do
  desc "Symlink application.yml"
  task :symlink do
    run "mkdir -p #{shared_path}/config"
    transfer :up, "config/application.yml", "#{shared_path}/config/application.yml", :via => :scp
    run "ln -sf #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
  after "deploy:finalize_update", "figaro:symlink"
end
