class AddMoreLinksToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :vimeo, :string
    add_column :projects, :flickr, :string
    add_column :projects, :youtube, :string
    add_column :projects, :drive, :string
  end
end
