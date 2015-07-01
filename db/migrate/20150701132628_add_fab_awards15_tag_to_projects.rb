class AddFabAwards15TagToProjects < ActiveRecord::Migration
  def change
    Project.all.each do |project|
      project.tag_list.add("Fab Awards 15")
      projext.save
    end
  end
end
