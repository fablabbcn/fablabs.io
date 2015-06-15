class AddMoreFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :twitter, :string
    add_column :projects, :facebook, :string
    add_column :projects, :googleplus, :string
    add_column :projects, :instagram, :string
    add_column :projects, :status, :string
    add_column :projects, :version, :string
    add_column :projects, :faq, :text
    add_column :projects, :scope, :text
    add_column :projects, :community, :text
    add_column :projects, :lookingfor, :text
  end
end
