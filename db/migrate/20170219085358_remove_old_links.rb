class RemoveOldLinks < ActiveRecord::Migration
  def change
    remove_column :organizations, :web
    remove_column :organizations, :github
    remove_column :organizations, :drive
    remove_column :organizations, :twitter
    remove_column :organizations, :flickr
    remove_column :organizations, :instagram
    remove_column :organizations, :bitbucket
    remove_column :organizations, :dropbox
    remove_column :organizations, :facebook
    remove_column :organizations, :googleplus
    remove_column :organizations, :youtube
    remove_column :organizations, :vimeo
    remove_column :projects, :web
    remove_column :projects, :github
    remove_column :projects, :drive
    remove_column :projects, :twitter
    remove_column :projects, :flickr
    remove_column :projects, :instagram
    remove_column :projects, :bitbucket
    remove_column :projects, :dropbox
    remove_column :projects, :facebook
    remove_column :projects, :googleplus
    remove_column :projects, :youtube
    remove_column :projects, :vimeo
  end
end
