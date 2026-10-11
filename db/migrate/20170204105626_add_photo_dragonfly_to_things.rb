class AddPhotoDragonflyToThings < ActiveRecord::Migration[4.2]
  def change
    add_column :things, :photo_uid, :string
    add_column :things, :photo_name, :string
  end
end
