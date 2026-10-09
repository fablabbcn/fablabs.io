class RemoveHeaderImageSrcToLabs < ActiveRecord::Migration[4.2]
  def change
    remove_column :labs, :header_image_src
  end
end
