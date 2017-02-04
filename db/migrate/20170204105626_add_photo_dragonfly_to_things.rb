class AddPhotoDragonflyToThings < ActiveRecord::Migration
  def change
    add_column :things, :photo_uid, :string
    add_column :things, :photo_name, :string
  end
end
