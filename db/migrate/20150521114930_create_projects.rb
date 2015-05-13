class CreateProjects < ActiveRecord::Migration

  def self.up
    create_table :projects do |t|
      t.string :type, index: true
      t.string :title
      t.text :description
      t.string :github
      t.string :web
      t.string :dropbox
      t.string :bitbucket

      t.belongs_to :lab, index: true
      t.belongs_to :owner, index: true

      t.timestamps
    end

  end

  # Drop table
  def self.down
    drop_table :projects
  end
end
