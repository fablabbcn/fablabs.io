class AddPhotoSrcToTools < ActiveRecord::Migration
  def change
    add_column :tools, :photo_src, :string
  end
end
