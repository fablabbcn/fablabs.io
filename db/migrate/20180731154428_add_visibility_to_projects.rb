class AddVisibilityToProjects < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :visibility, :integer, default: 1

    add_index :projects, :visibility
  end
end
