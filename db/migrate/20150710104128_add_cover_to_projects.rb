class AddCoverToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :cover, :string
  end
end
