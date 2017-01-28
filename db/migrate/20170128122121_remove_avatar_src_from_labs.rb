class RemoveAvatarSrcFromLabs < ActiveRecord::Migration
  def change
    remove_column :labs, :avatar_src
  end
end
