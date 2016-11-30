class AddDiscourseToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :discourse_id, :string
    add_column :projects, :discourse_errors, :text
  end
end
