def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "echo 'export LC_ALL=\"en_US.UTF-8\"' >> ~/.bashrc"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install vim build-essential zlib1g-dev curl git-core libgeoip-dev python-software-properties libssl-dev openssl libreadline-dev libpq-dev"
  end

  # # # http://www.bencurtis.com/2011/12/skipping-asset-compilation-with-capistrano/
  # desc "Check if assets have changed and need recompiling"
  # namespace :assets do
  #   task :precompile, :roles => :web, :except => { :no_release => true } do
  #     if previous_revision
  #       from = source.next_revision(current_revision)
  #       if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
  #         run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
  #       else
  #         logger.info "Skipping asset pre-compilation because there were no asset changes"
  #       end
  #     end
  #   end
  # end

end
