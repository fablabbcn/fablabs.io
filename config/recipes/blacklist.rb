namespace :blacklist do
  desc "Symlink words.yml"
  task :symlink do
    run "mkdir -p #{shared_path}/config"
    transfer :up, "config/words.yml", "#{shared_path}/config/words.yml", :via => :scp
    run "ln -sf #{shared_path}/config/words.yml #{release_path}/config/words.yml"
  end
  after "deploy:finalize_update", "blacklist:symlink"
end
