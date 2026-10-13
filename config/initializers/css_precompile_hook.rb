if Rake::Task.task_defined?("assets:precompile")
  Rake::Task["assets:precompile"].enhance do
    puts "Building Admin CSS..."
    system("yarn run build:css:activeadmin")
  end
end
