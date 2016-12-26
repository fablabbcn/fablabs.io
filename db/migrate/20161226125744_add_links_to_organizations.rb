class AddLinksToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :web, :string
    add_column :organizations, :github, :string
    add_column :organizations, :drive, :string
    add_column :organizations, :twitter, :string
    add_column :organizations, :flickr, :string
    add_column :organizations, :instagram, :string
    add_column :organizations, :bitbucket, :string
    add_column :organizations, :dropbox, :string
    add_column :organizations, :facebook, :string
    add_column :organizations, :googleplus, :string
    add_column :organizations, :youtube, :string
    add_column :organizations, :vimeo, :string
  end
end
