# frozen_string_literal: true

namespace :export do
  desc 'Export all projects'
  task :projects, [:output] => [:environment] do |_task, args|
    @projects = Project.all.includes(:lab, :owner)
    @json = Api::V2::ApiProjectSerializer.new(@projects).serialized_json
    if args[:output]
      File.open(args[:output], 'w') do |f|
        f.write(@json)
      end
    end
    puts @json
  end
end
