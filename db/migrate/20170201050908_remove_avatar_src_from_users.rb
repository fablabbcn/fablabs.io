class RemoveAvatarSrcFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :avatar_src
  end
end
