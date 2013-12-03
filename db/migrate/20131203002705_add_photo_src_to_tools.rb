class AddPhotoSrcToMachines < ActiveRecord::Migration
  def change
    add_column :machines, :photo_src, :string
  end
end
