class RemovePhotoSrcToThings < ActiveRecord::Migration
  def change
    remove_column :things, :photo_src, :string
  end
end
