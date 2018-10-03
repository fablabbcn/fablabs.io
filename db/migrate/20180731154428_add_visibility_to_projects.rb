class AddVisibilityToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :visibility, :integer, default: 1

    add_index :projects, :visibility
  end
end
