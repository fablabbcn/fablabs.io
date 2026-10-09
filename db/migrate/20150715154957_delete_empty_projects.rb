class DeleteEmptyProjects < ActiveRecord::Migration[4.2]
  def change
    Project.all.each do |project|
      if project.title.blank? and project.description.blank?
        project.destroy
      end
    end
  end
end
