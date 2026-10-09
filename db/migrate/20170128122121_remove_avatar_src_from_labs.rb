class RemoveAvatarSrcFromLabs < ActiveRecord::Migration[4.2]
  def change
    remove_column :labs, :avatar_src
  end
end
