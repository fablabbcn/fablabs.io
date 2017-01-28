class RemoveHeaderImageSrcToLabs < ActiveRecord::Migration
  def change
    remove_column :labs, :header_image_src
  end
end
