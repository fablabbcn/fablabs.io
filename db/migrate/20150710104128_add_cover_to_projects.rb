class AddCoverToProjects < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :cover, :string
  end
end
