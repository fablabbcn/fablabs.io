class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vimeo, :string
    add_column :users, :flickr, :string
    add_column :users, :youtube, :string
    add_column :users, :drive, :string
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :web, :string
    add_column :users, :github, :string
    add_column :users, :bitbucket, :string
    add_column :users, :googleplus, :string
    add_column :users, :instagram, :string
  end
end
