class DeleteEmptyProjects < ActiveRecord::Migration
  def change
    Project.all.each do |project|
      if project.title.blank? and project.description.blank?
        project.destroy
      end
    end
  end
end
