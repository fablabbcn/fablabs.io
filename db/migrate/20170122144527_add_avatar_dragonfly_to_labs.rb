class AddAvatarDragonflyToLabs < ActiveRecord::Migration[4.2]
  def change
    add_column :labs, :avatar_uid,  :string
    add_column :labs, :avatar_name, :string
  end
end
