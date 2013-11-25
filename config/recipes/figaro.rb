namespace :figaro do
  # desc "SCP transfer figaro configuration to the shared folder"
  # task :setup do
  #   run "mkdir -p #{shared_path}/config"
  #   transfer :up, "config/application.yml", "#{shared_path}/config/application.yml", via: :scp
  # end

  desc "Symlink application.yml to the release path"
  task :symlink do
    run "ln -sf #{shared_path}/config/application.yml #{latest_release}/config/application.yml"
  end

  desc "Check if figaro configuration file exists on the server"
  task :check do
    begin
      run "test -f #{shared_path}/config/application.yml"
    rescue Capistrano::CommandError
      unless fetch(:force, false)
        logger.important 'application.yml file does not exist on the server "shared/config/application.yml"'
        exit
      end
    end
  end
end
after "deploy:setup", "figaro:setup"
after "deploy:finalize_update", "figaro:symlink"
