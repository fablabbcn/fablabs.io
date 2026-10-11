class RemovePhotoSrcToThings < ActiveRecord::Migration[4.2]
  def change
    remove_column :things, :photo_src, :string
  end
end
