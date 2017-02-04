class AddPhotoDragonflyToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :photo_uid, :string
    add_column :documents, :photo_name, :string
  end
end
