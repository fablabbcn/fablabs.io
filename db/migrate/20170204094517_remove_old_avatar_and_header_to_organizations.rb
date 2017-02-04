class RemoveOldAvatarAndHeaderToOrganizations < ActiveRecord::Migration
  def change
    remove_column :organizations, :avatar_src, :string
    remove_column :organizations, :header_image_src, :string
  end
end
