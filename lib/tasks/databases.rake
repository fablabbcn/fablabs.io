#{Rails.root}/lib/tasks/databases.rake
# monkey patch ActiveRecord to avoid There are n other session(s) using the database.
# from http://stackoverflow.com/questions/17615574/cucumber-and-rspec-testing-with-zeus-postgres-is-being-accessed-by-other-users
def drop_database(config)
  case config['adapter']
  when /mysql/
    ActiveRecord::Base.establish_connection(config)
    ActiveRecord::Base.connection.drop_database config['database']
  when /sqlite/
    require 'pathname'
    path = Pathname.new(config['database'])
    file = path.absolute? ? path.to_s : File.join(Rails.root, path)

    FileUtils.rm(file)
  when /postgresql/
    begin
      ActiveRecord::Base.establish_connection(config.merge('database' => 'postgres', 'schema_search_path' => 'public'))
      ActiveRecord::Base.connection.select_all("select * from pg_stat_activity order by procpid;").each do |x|
        if config['database'] == x['datname'] && x['current_query'] =~ /<IDLE>/
          ActiveRecord::Base.connection.execute("select pg_terminate_backend(#{x['procpid']})")
        end
      end
      ActiveRecord::Base.connection.drop_database config['database']
    rescue # in PG 9.2 column procpid was renamed pid and the query status is checked not using 'current_query' but using 'state'
      ActiveRecord::Base.establish_connection(config.merge('database' => 'postgres', 'schema_search_path' => 'public'))
      ActiveRecord::Base.connection.select_all("select * from pg_stat_activity order by pid;").each do |x|
        if config['database'] == x['datname'] && x['state'] =~ /idle/
          ActiveRecord::Base.connection.execute("select pg_terminate_backend(#{x['pid']})")
        end
      end
      ActiveRecord::Base.connection.drop_database config['database']
    end
  end
end