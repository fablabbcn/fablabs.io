set_default(:postgresql_version, 9.2)
set_default(:postgresql_user) { ENV['DB_USERNAME'] }
set_default(:postgresql_password) { ENV['DB_PASSWORD'] }
set_default(:postgresql_database) { ENV['DB_NAME'] }
set_default(:postgresql_pid) { "/var/run/postgresql/#{postgresql_version}-main.pid" }

namespace :postgresql do
  desc "Install PostgreSQL."
  task :install, roles: :db do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install python-software-properties"
    run "#{sudo} add-apt-repository -y ppa:pitti/postgresql"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install postgresql-#{postgresql_version} postgresql-client-#{postgresql_version} postgresql-contrib-#{postgresql_version} postgresql-server-dev-#{postgresql_version} libpq-dev"
  end
  after "deploy:install", "postgresql:install"

  desc "Create a database for this application."
  task :create_database, roles: :db do
    run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}
    run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user};"}
  end
  after "deploy:setup", "postgresql:create_database"
end
