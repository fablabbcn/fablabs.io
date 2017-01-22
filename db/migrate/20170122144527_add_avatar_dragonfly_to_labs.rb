class AddAvatarDragonflyToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :avatar_uid,  :string
    add_column :labs, :avatar_name, :string
  end
end
