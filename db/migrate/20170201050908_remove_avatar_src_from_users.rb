class RemoveAvatarSrcFromUsers < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :avatar_src
  end
end
