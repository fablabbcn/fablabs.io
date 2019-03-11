# frozen_string_literal: true
require 'json/ext'
namespace :export do
  desc 'Export all projects'
  task :projects, [:output] => [:environment] do |_task, args|
    @projects = Project.all.includes(:owner,:lab,:steps, :links, :documents,:favourites, :tags )
    if args[:output]
      File.open(args[:output], 'w') do |f|
        f.write(@projects.to_json(include: {
                owner: {only: [:id, :username, :first_name, :last_name, :email]}, 
                lab: {only: [:id, :name, :avatar_url]}, 
                steps: {only: [:title, :description, :position, :links]}, 
                links: {only: :url}, 
                documents: { methods: :photo_url }
             }))
      end
    else
      puts @projects.to_json
    end
  end
end
