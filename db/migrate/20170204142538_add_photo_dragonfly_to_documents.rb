class AddPhotoDragonflyToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :photo_uid, :string
    add_column :documents, :photo_name, :string
  end
end
