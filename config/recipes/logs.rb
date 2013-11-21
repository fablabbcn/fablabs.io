namespace :logs do
  %w(unicorn production nginx).each do |log|
    desc "tail #{log} log files"
    task "tail_#{log}".to_sym, :roles => :app do
      trap("INT") { puts 'Interupted'; exit 0; }
      run "tail -f #{shared_path}/log/#{log}.log" do |channel, stream, data|
        puts "#{channel[:host]}: #{data}"
        break if stream == :err
      end
    end
  end
end
